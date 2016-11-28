//
//  PostbeService.h
//  
//
//  Created by scott.lin on 1/28/16.
//  Copyright (c) 2016 ChinaPnR. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PostbeServiceDelegate <NSObject>

@optional
/*!
 *  @author scott.lin, 16-01-28
 *
 *  @brief 批量发送成功回调
 */
- (void)onBatchPostbeSuccess;

/*!
 *  @author scott.lin, 16-01-28
 *
 *  @brief 批量发送失败回调
 */
- (void)onBatchPostbeFail;
@end


@interface PostbeService : NSObject

@property (nonatomic, assign) id<PostbeServiceDelegate> delegate;
/*!
 *  @author scott.lin, 16-01-25
 *
 *  @brief 单条发送
 *  @param functionId postbe唯一标示符
 */
+(void)postbe:(NSString *)functionId;

/*!
 *  @author scott.lin, 16-01-26
 *
 *  @brief 单条发送，含有附加信息
 *  @param functionId   postbe功能号
 *  @param additonParam 附件信息
 */
+(void)postbe:(NSString *)functionId additionParam:(NSDictionary *)additonParam;

/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 批量发送，含有附加信息
 *  @param dataArray   批量发送数据（json字符串数组）
 *  @param delegate 发送结果回调代理
 */
+(void)batchPostbe:(NSMutableArray*)dataArray delegate:(id<PostbeServiceDelegate>)delegate;


@end
