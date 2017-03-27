//
//  PostbeSetting.h
//  BatchPosbePoc
//
//  Created by user on 16/2/4.
//  Copyright © 2016年 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostbeHelper.h"

// 去除release的NSLog代码
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif


//#define POSTBE_BATCH_ON //POSTBE框架开关：控制单条发送是否缓存在数据库
#define POSTBE_SEND_COUNT_DEFAULT 100 //批量发送的数量
#define POSTBE_SEND_COUNT_MAX     1024 //批量发送的数量最大值
#define POSTBE_SALT  @"chinapnr_postbe" //checkvalue盐值
#define RESPONSE_CODE @"return_code"  //postbe发送返回的code标示
#define PRODUCT_VERSION    //是否生产版本


#ifndef PRODUCT_VERSION

#define POSTBE_URL_D     @"http://192.168.0.206:9999"                    //测试版本单条发送URL
#define POSTBE_URL_BATCH_D  @"http://192.168.0.206:9999/batchSend"        //测试版本批量发送URL

#else

#define POSTBE_URL_D      @"http://mobileservice.chinapnr.com/postbe"      //生产版本单条发送URL
#define POSTBE_URL_BATCH_D  @"http://mobileservice.chinapnr.com/batchSend" //生产版本批量发送URL

#endif



@interface PostbeSetting : NSObject
@property(nonatomic,strong) NSString *postUrl;
@property (nonatomic,strong) NSMutableDictionary *headData;       /*<!postbe固定头部的配置，*/
@property (nonatomic,strong) NSMutableArray      *checkKeys;      /*<!校验值*/
@property (nonatomic,strong) NSMutableDictionary *additionParam;  /*<!postbe附加参数的配置，*/

/*!
 *  @author scott.lin, 16-02-04
 *
 *  @brief 获取PostbeSetting单例
 */
+(instancetype)shareInstance;

@end
