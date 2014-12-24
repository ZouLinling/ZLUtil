//
//  CoreDataManager.h
//  BaseProject
//
//  Created by Zou on 6/12/14.
//  Copyright (c) 2014 zou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObject;

@interface CoreDataManager : NSObject
@property(strong,nonatomic,readonly)NSManagedObjectModel* managedObjectModel;

@property(strong,nonatomic,readonly)NSManagedObjectContext* managedObjectContext;

@property(strong,nonatomic,readonly)NSPersistentStoreCoordinator* persistentStoreCoordinator;

@property(strong,nonatomic) NSString *modelFileName;

@property(strong,nonatomic) NSString *sqliteFileName;

//获取CoreDataManager实例
+ (CoreDataManager*)getInstance;

//获取NSManagedObject实例
- (NSManagedObject *)createManagedObject:(Class)entityClass;
//删除指定的实例（数据库中一条记录）
- (BOOL)deleteManagedObject:(NSManagedObject *)object entity:(Class)entityClass;
//清空指定的表
- (void) deleteAllObjects: (Class)entityClass;
//根据指定的查询条件查询数据,可以用来确认数据库中是否有相关实例
- (NSArray *)fetchManagedObjectsByPredicate:(NSPredicate *)predicate
                                 entity:(Class)entityClass
                            sortDescriptors:(NSArray *)sortDescriptors;
//保存数据库
-(BOOL) saveContext:(Class)entityClass;
@end
