//
//  PostbeSetting.h
//  BatchPosbePoc
//
//  Created by user on 16/2/4.
//  Copyright © 2016年 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostbeHelper.h"
//#import "DeviceIntrospection.h"
//#import "CPDeviceUtil.h"


// 去除release的NSLog代码
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

//POSTBE框架开关：控制单条发送是否缓存在数据库，是否启动postbe管理程序
//#define POSTBE_ON

//批量发送的数量
#define POSTBE_SEND_COUNT_DEFAULT 100
//批量发送的数量最大值
#define POSTBE_SEND_COUNT_MAX     1024

//checkvalue盐值
#define POSTBE_SALT  @"chinapnr_postbe"
//不清楚，天天盈要用
#define DM_DEFAULT_VALUE      @"#"
//postbe发送返回的code标示
#define RESPONSE_CODE @"return_code"
//是否生产版本
//#define PRODUCT_VERSION



#ifndef PRODUCT_VERSION
//测试版本单条发送URL
#define POSTBE_URL     @"http://192.168.0.206:9999"
//测试版本批量发送URL
#define POSTBE_URL_BATCH @"http://192.168.0.206:9999/batchSend"
#else
//生产版本单条发送URL
#define POSTBE_URL     @"http://mobileservice.chinapnr.com/postbe"
//生产版本批量发送URL
#define POSTBE_URL_BATCH @"http://mobileservice.chinapnr.com/batchSend"
#endif



@interface PostbeSetting : NSObject

@property (nonatomic,strong) NSMutableDictionary *headData;/**<!postbe固定头部的配置，*/

@property (nonatomic,strong) NSMutableArray      *checkKeys;/**<!校验值*/

@property (nonatomic,strong) NSMutableDictionary *additionParam;/**<!postbe附加参数的配置，*/

/*!
 *  @author scott.lin, 16-02-04
 *
 *  @brief 获取PostbeSetting单例
 */
+(instancetype)shareInstance;

@end
