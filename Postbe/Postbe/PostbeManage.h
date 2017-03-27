//
//  PostbeManage.h
//  Postbe
//
//  Created by scott.lin on 16/1/27.
//  Copyright © 2016年 ChinaPnR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostbeSetting.h"

@interface PostbeManage : NSObject
/*!
 *  @author scott.lin, 16-01-28
 *
 *  @brief 获取PostbeManage单例
 */
+(instancetype)shareInstance;

/*!
 *  @author scott.lin, 16-02-04
 *
 *  @brief 配置postbe头部参数
 *  @param name  参数名
 *  @param value 参数值
 */

-(void)configHeadParam:(NSString*)name value:(id)value;
/*!
 *  @author scott.lin, 16-02-19
 *
 *  @brief 参与check的key配置
 *  @param checkKeys 参与check的key集合
 */

-(void)configCheckKeys:(NSArray*)checkKeys;
/*!
 *  @author scott.lin, 16-02-19
 *
 *  @brief 配置postbe附加参数
 *  @param name  参数名
 *  @param value 参数值
 */

-(void)configAdditionParam:(NSString*)name value:(id)value;

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 初始化Post管理程序，批量发送数量为默认
 */
-(void)startup;

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 初始化Post管理程序，并配置批量发送的数量
 *  @param count 批量发送的数量
 */
-(void)startupWithSendCount:(NSUInteger)count;

-(void)configPostUrl:(NSString *)url;


@end
