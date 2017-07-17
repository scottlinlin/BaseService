//
//  PCityDB.m
//  subuy
//
//  Created by scott.lin on 16/09/19.
//  Copyright (c) 2016年 ChinaPnR. All rights reserved.
//

#import "PCityDB.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

#define DATABASENAME @"PCity.sqlite" // 本地数据库文件名

static PCityDB *sInstance = nil;

@interface PCityDB ()

@property (nonatomic, strong) FMDatabaseQueue* databaseQueue;   /*!< DB同步队列 */
@property (nonatomic, strong) FMDatabase* database;             /*!< DB对象 */

@end

@implementation PCityDB
/*!
 *  @author scott.lin, 16-09-19
 *
 *  @brief 生产DB单例
 *  @return DB实例
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
 *  @author scott.lin, 16-09-19
 *
 *  @brief 创建数据库
 */
- (void)createDatabase
{
    NSBundle *selfBundle = [NSBundle bundleForClass:[self class] ];
    NSString *filePath = [selfBundle pathForResource:@"PCity" ofType:@"sqlite"];
    self.database = [FMDatabase databaseWithPath:filePath];

    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
}

/*!
 *  @author scott.lin, 16-09-19
 *
 *  @brief 创建PCity数据表
 */
-(void)createTable{
    if (![self.database tableExists:@"PCity"]) {
        [self.database executeUpdate:@"CREATE TABLE PCity(\
         uuid text PRIMARY KEY  NOT NULL,\
         areaId text,\
         areaName text,\
         provId text,\
         provName text,\
         areaIdCard text,\
         provIdCard text)"];
        /*
         记录唯一标示
         市id
         市名
         省id
         市idCard
         省idCard
         */
    }
}


/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 省市插入数据库
 */
- (void)insertData
{
    if ([self getProvince].count >0)
        return;
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PCity" ofType:@"sqlite"];
    NSString *pCityStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *pCityArr =  [NSJSONSerialization JSONObjectWithData:[pCityStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    for (NSDictionary *dic in pCityArr) {
        [self.databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            BOOL result =[db executeUpdate:@"INSERT INTO PCity VALUES(?,?,?,?,?,?,?)",
                          dic[@"_id"],dic[@"areaId"],dic[@"areaName"],dic[@"provId"],dic[@"provName"],dic[@"areaIdCard"],dic[@"provIdCard"]];
            if (!result) {
                *rollback = YES;
                return ;
            }
        }];

    }
}


/*!
 *  @author scott.lin, 16-09-20
 *
 *  @brief 获取全部省份数据
 *  @return 全部省份数据
 */
- (NSMutableArray*)getProvince
{
    FMDatabase* db = self.database;
    if ([db open]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString* sql = [NSString stringWithFormat:@"SELECT DISTINCT PROV_NAME,GA_PROV_ID FROM LOCA  ORDER BY GA_PROV_ID ASC"];
        
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
 *  @author scott.lin, 16-09-20
 *
 *  @brief 获取指定省的市数据
 *  @return 市数据
 */
- (NSMutableArray*)getCity:(NSString*)province
{
    FMDatabase* db = self.database;
    if ([db open]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString* sql = [NSString stringWithFormat:@"SELECT DISTINCT DIST_NAME,GA_AREA_ID,DIST_ID FROM LOCA WHERE PROV_NAME ='%@' ORDER BY GA_AREA_ID ASC",province];
        
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
 *  @author scott.lin, 16-11-18
 *
 *  @brief 获取所以省市数据
 *  @return 市数据
 */
- (NSMutableArray*)getAllCity
{
    FMDatabase* db = self.database;
    if ([db open]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString* sql = [NSString stringWithFormat:@"SELECT * FROM LOCA  ORDER BY GA_AREA_ID ASC"];
        
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
 *  @author scott.lin, 16-09-20
 *
 *  @brief 获取指定市数据
 *  @return 市数据
 */
- (NSMutableArray*)getCityWithName:(NSString*)cityName{
    FMDatabase* db = self.database;
    if ([db open]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString* sql = [NSString stringWithFormat:@"SELECT DISTINCT DIST_NAME,GA_AREA_ID,DIST_ID FROM LOCA WHERE DIST_NAME ='%@'",cityName];
        
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


@end
