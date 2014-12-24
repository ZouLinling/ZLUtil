//
//  CoreDataManager.m
//  BaseProject
//
//  Created by Zou on 6/12/14.
//  Copyright (c) 2014 zou. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "NSObject+ClassName.h"

@implementation CoreDataManager

@synthesize managedObjectModel=_managedObjectModel;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;


/**
 *  获取CoreDataManager实例
 *  注意：如果datamodel的文件名不是Model的，需要为其设置，否则会强制关闭
 *  默认的数据库文件的名字是Default.sqlite，如果需要更改，也可以进行修改，建议在AppDelegate的
 *  didFinishLaunchingWithOptions方法中进行设置，例如：
    CoreDataManager *coreDataManager = [CoreDataManager getInstance];
    coreDataManager.modelFileName = @"MyModel";
    coreDataManager.sqliteFileName = @"MyDataBase.sqlite";
 
    从数据库中查询
    CoreDataManager *coreDataManager = [CoreDataManager getInstance];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",name];
    NSMutableArray *records = [[coreDataManager fetchManagedObjectsByPredicate:predicate entity:User.class sortDescriptors:nil] mutableCopy];
 
    插入新值到数据库
    CoreDataManager *coreDataManager = [CoreDataManager getInstance];
    User *user = nil;
    user = (User*)[NSEntityDescription insertNewObjectForEntityForName:[User.class className] inManagedObjectContext:coreDataManager.managedObjectContext];
    user.name = name;
    user.password = password;
    user.loginTimes =  1;
    user.lastLoginTime = [Util currentTimeString];
    user.userID = @"1234";
    [coreDataManager saveContext:User.class];
 
    删除单条记录，需要先查询，这里是查询所有记录
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[entityClass className] inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
 
    NSError *error;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *managedObject in items) {
        [self deleteManagedObject:managedObject entity:entityClass];
    }
 
    删除整个表中内容
    [[CoreDataManager getInstance] deleteAllObjects:[Search class]];
 
    更新某条记录
    先查询出来，再删除，再新增
 *
 */
+ (CoreDataManager*)getInstance
{
    static CoreDataManager *instance= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataManager alloc] init];
    });
    return instance;
}

//托管对象
-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel!=nil) {
        return _managedObjectModel;
    }
    NSURL* modelURL=[[NSBundle mainBundle] URLForResource:_modelFileName == nil ? @"Model":_modelFileName withExtension:@"momd"];
    _managedObjectModel=[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
//托管对象上下文
-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext!=nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator* coordinator=[self persistentStoreCoordinator];
    if (coordinator!=nil) {
        _managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
//持久化存储协调器
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator!=nil) {
        return _persistentStoreCoordinator;
    }
    NSString* docs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSURL* storeURL=[NSURL fileURLWithPath:[docs stringByAppendingPathComponent:_sqliteFileName == nil ? @"Default.sqlite":_modelFileName]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
        abort(); //测试用
    }
    return _persistentStoreCoordinator;
}
-(NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObject *)createManagedObject:(NSString*)entityName
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    id object = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:[self managedObjectContext]];
    
    NSAssert(object, @"Assert object == nil");
    
    return object;
}

- (BOOL)deleteManagedObject:(NSManagedObject *)object entity:(Class)entityClass;
{
    BOOL isSucceed = NO;
    
    if (!object) {
        return isSucceed;
    }
    
    NSManagedObjectContext *moContext = [self managedObjectContext];
    [moContext deleteObject:object];
    return [self saveContext:entityClass];
}

- (void) deleteAllObjects: (Class)entityClass;
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[entityClass className] inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items) {
    	[self deleteManagedObject:managedObject entity:entityClass];
    }
}

- (NSArray *)fetchManagedObjectsByPredicate:(NSPredicate *)predicate
                                     entity:(Class)entityClass
                            sortDescriptors:(NSArray *)sortDescriptors;
{
    NSFetchRequest *localFetch = [NSFetchRequest fetchRequestWithEntityName:[entityClass className]];
    
    localFetch.predicate = predicate;
    localFetch.sortDescriptors = sortDescriptors;
    
    __block NSArray *managedObjectList = nil;
    __block NSError *error = nil;
    [[self managedObjectContext] performBlockAndWait:^{
        managedObjectList = [[self managedObjectContext] executeFetchRequest:localFetch error:&error];
    }];
    
    if (error) {
        NSLog(@"Error fetch:%@ %@",[entityClass className], error);
    }
    return managedObjectList;
}

-(BOOL) saveContext:(Class)entityClass
{
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
    	NSLog(@"Error save:%@ %@",[entityClass className], error);
        return NO;
    }
    return YES;
}

@end
