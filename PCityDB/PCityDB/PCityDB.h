//
//  PCityDB.h
//  subuy
//
//  Created by scott.lin on 16/09/19.
//  Copyright (c) 2016年 ChinaPnR. All rights reserved.
//
// 数据库操作类，随处可用

#import <Foundation/Foundation.h>



@interface PCityDB : NSObject

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 生产DB单例
 *  @return DB实例
 */
+(instancetype)sharedInstance;

/*!
 *  @author scott.lin, 16-09-20
 *
 *  @brief 获取全部省份数据
 *  @return 全部省份数据
 */
- (NSMutableArray*)getProvince;

/*!
 *  @author scott.lin, 16-09-20
 *
 *  @brief 获取指定省的市数据
 *  @return 市数据
 */
- (NSMutableArray*)getCity:(NSString*)province;


/*!
 *  @author scott.lin, 16-11-18
 *
 *  @brief 获取所以省市数据
 *  @return 市数据
 */
- (NSMutableArray*)getAllCity;

/*!
 *  @author scott.lin, 16-09-20
 *
 *  @brief 获取指定市数据
 *  @return 市数据
 */
- (NSMutableArray*)getCityWithName:(NSString*)cityName;
@end
