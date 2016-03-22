//
//  CoreDataManager.h
//  BaseProject
//
//  Created by Zou on 6/12/14.
//  Copyright (c) 2014 zou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObject;
@class NSManagedObjectModel;
@class NSManagedObjectContext;
@class NSPersistentStoreCoordinator;

@interface CoreDataManager : NSObject

@property(strong,nonatomic,readonly)NSManagedObjectModel* managedObjectModel;

@property(strong,nonatomic,readonly)NSManagedObjectContext* managedObjectContext;

@property(strong,nonatomic,readonly)NSPersistentStoreCoordinator* persistentStoreCoordinator;

@property(strong,nonatomic) NSString *modelFileName;

@property(strong,nonatomic) NSString *sqliteFileName;

/**
 *  获取CoreDataManager实例
 *
 *  @return
 */
+ (CoreDataManager*)getInstance;

/**
 *  构造函数
 *
 *  @param modelFileName  模型文件名称
 *  @param sqliteFileName 数据库文件名称
 *
 *  @return
 */
-(id)initWithFileName:(NSString*)modelFileName sqliteFileName:(NSString*)sqliteFileName;

/**
 *  获取NSManagedObject实例
 *
 *  @param entityClass 创建的实体对象
 *
 *  @return
 */
- (NSManagedObject *)createManagedObject:(Class)entityClass;

/**
 *  删除指定的实例（数据库中一条记录）
 *
 *  @param object      需要删除的NSManagedObject实例
 *  @param entityClass 目标实体对象
 *
 *  @return
 */
- (BOOL)deleteManagedObject:(NSManagedObject *)object entity:(Class)entityClass;

/**
 *  清空指定的表
 *
 *  @param entityClass 目标实体对象
 */
- (void) deleteAllObjects: (Class)entityClass;

/**
 *  根据指定的查询条件查询数据,可以用来确认数据库中是否有相关实例
 *
 *  @param predicate       查询条件
 *  @param entityClass     目标实体对象
 *  @param sortDescriptors 对象排序数组
 *
 *  @return
 */
- (NSArray *)fetchManagedObjectsByPredicate:(NSPredicate *)predicate
                                 entity:(Class)entityClass
                            sortDescriptors:(NSArray *)sortDescriptors;

/**
 *  保存数据库
 *
 *  @param entityClass 目标实体对象
 *
 *  @return
 */
-(BOOL) saveContext:(Class)entityClass;

/**
 *  单表查询
 *
 *  @param entityNmae 表名
 *  @param predicate  查询条件
 *
 *  @return 查询结果
 */
+(NSArray*)query:(NSString*)entityNmae predicate:(NSPredicate *)predicate;

@end
