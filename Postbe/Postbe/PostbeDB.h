//
//  PostbeDB.h
//  Postbe
//
//  Created by scott.lin on 16/1/27.
//  Copyright (c) 2016年 ChinaPnR. All rights reserved.
//
// 数据库操作类，随处可用

#import <Foundation/Foundation.h>



@interface PostbeDB : NSObject

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 生产PostbeDB单例
 *  @return PostbeDB实例
 */
+(instancetype)sharedInstance;

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief postbe记录插入数据库
 *  @param data 记录数据,json字符串
 *  @return 是否成功
 */
- (void)insertData:(NSString*)data;

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 根据uuid序列删除Postbe数据
 *  @param dataArray 要删除的postbe数组
 *  @return 是否成功
 */
- (void)deleteData:(NSMutableArray*)dataArray;

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 获取Postbe数据个数
 *  @return Postbe数据个数
 */
- (int)getNum;

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 获取指定数量的postbe数据
 *  @param count 指定数量
 *  @return 指定数量的postbe数据
 */
- (NSMutableArray*)getData:(NSUInteger)count;
@end
