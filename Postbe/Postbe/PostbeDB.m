//
//  PostbeDB.m
//  Postbe
//
//  Created by scott.lin on 16/1/27.
//  Copyright (c) 2016年 ChinaPnR. All rights reserved.
//

#import "PostbeDB.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "PostbeHelper.h"

#define POSTBE_DATABASENAME @"PostbeDB.sqlite" // 本地数据库文件名

static PostbeDB *sInstance = nil;

@interface PostbeDB ()

@property (nonatomic, strong) FMDatabaseQueue* databaseQueue;   /*!< DB同步队列 */
@property (nonatomic, strong) FMDatabase* database;             /*!< DB对象 */

@end

@implementation PostbeDB
/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 生产PostbeDB单例
 *  @return PostbeDB实例
 */
+(instancetype)sharedInstance{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sInstance = [[[self class] alloc] init];
    });
    
    return sInstance;
}

-(id)init{
    self = [super init];
    if (self) {
        self.databaseQueue = [[FMDatabaseQueue alloc] init];
        self.database = [[FMDatabase alloc] init];
        [self createDatabase];
    }
    return self;
}

-(void)dealloc {
    if (self.database) {
        [self.database close];
    }
    if (self.databaseQueue) {
        [self.databaseQueue close];
    }
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 创建数据库
 */
- (void)createDatabase
{
    self.database = [FMDatabase databaseWithPath:AppDocumentsPath(POSTBE_DATABASENAME)];
    if ([self.database open]) {
        //创建postbe数据库
        [self createPostbeTable];
        
        //关闭数据库
        [self.database close];
    }
    
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:AppDocumentsPath(POSTBE_DATABASENAME)];
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 创建postbe数据表
 */
-(void)createPostbeTable{
    if (![self.database tableExists:@"Postbe"]) {
        [self.database executeUpdate:@"CREATE TABLE Postbe(\
         uuid text PRIMARY KEY  NOT NULL,\
         data text,\
         time text,\
         ext text)"];
        /*
         记录唯一标示
         记录数据     json格式
         记录时间     格式yyyy-MM-dd HH:mm:ss.SSS
         预留字段
         */
    }
}


/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief postbe记录插入数据库
 *  @param data 记录数据,json字符串
 *  @return 是否成功
 */
- (void)insertData:(NSString*)data
{
    [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result =[db executeUpdate:@"INSERT INTO Postbe VALUES(?,?,?,?)",
                      [self getUUID],data,[self dateToString],@""];
        if (!result) {
            *rollback = YES;
            return ;
        }
    }];
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 根据uuid序列删除Postbe数据
 *  @param dataArray 要删除的postbe数组
 *  @return 是否成功
 */
- (void)deleteData:(NSMutableArray*)dataArray{
     [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSDictionary *data in dataArray) {
            NSString *uuid = [data objectForKey:@"uuid"];
            BOOL result =[db executeUpdate:@"DELETE FROM Postbe WHERE uuid = ?",uuid];
            if (!result) {
                *rollback = YES;
                return ;
            }
        }
         [dataArray removeAllObjects];
     }];
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 获取Postbe数据个数
 *  @return Postbe数据个数
 */
- (int)getNum
{
    FMDatabase* db = self.database;
    int count;
    if ([db open]) {
        NSString* sql = @"SELECT COUNT(uuid) FROM Postbe";
        count = [db intForQuery:sql];
        [db close];
    }
    return count;
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 获取指定数量的postbe数据
 *  @param count 指定数量
 *  @return 指定数量的postbe数据
 */
- (NSMutableArray*)getData:(NSUInteger)count
{
    FMDatabase* db = self.database;
    if ([db open]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString* sql = [NSString stringWithFormat:@"SELECT * FROM Postbe LIMIT %lu",count];
        
        // 开始查询
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSDictionary* data = [rs resultDictionary];
            [array addObject:data];
        }
        [db close];
        return array;
    }
    
    return nil;
}


/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 获取唯一值uuid
 *  @return 返回唯一值uuid
 */
-(NSString*)getUUID{
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *uuid = (__bridge_transfer NSString *)CFStringCreateCopy( NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return uuid;
}

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 将NSDate转换为字符串
 *  @return 时间字符串
 */
- (NSString*)dateToString
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    return [df stringFromDate:[NSDate date]];
}







@end
