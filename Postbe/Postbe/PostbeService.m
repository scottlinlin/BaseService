//
//  PostbeService.m
//
//
//  Created by scott.lin on 1/28/16.
//  Copyright (c) 2016 ChinaPnR. All rights reserved.
//

#import "PostbeService.h"
#import "AFNetworking.h"
#import "PostbeSetting.h"
#import "PostbeDB.h"


@interface PostbeService ()

@end

@implementation PostbeService

/*!
 *  @author scott.lin, 16-01-25
 *
 *  @brief 单条发送
 *  @param functionId postbe功能号
 */
+ (void)postbe:(NSString *)functionId{

    [self.class postbe:functionId additionParam:nil];
}

/*!
 *  @author scott.lin, 16-01-26
 *
 *  @brief 单条发送，含有附加信息
 *  @param functionId   postbe功能号
 *  @param additonParam 附件信息
 */
+ (void)postbe:(NSString *)functionId additionParam:(NSDictionary *)additionParam{
    
    NSDictionary *headData = [[PostbeSetting shareInstance] headData];
    NSArray *checkKeys = [[PostbeSetting shareInstance] checkKeys];

    //添加function_id
    NSMutableDictionary *param = [headData mutableCopy];
    [param setObject:functionId forKey:@"function_id"];
    
    //添加checkvalue
    NSMutableString *checkSeq = [NSMutableString new];
    for (NSString *key in checkKeys) {
        NSString *value = [param objectForKey:key];
        [checkSeq appendString:value];
    }
    [checkSeq appendString:POSTBE_SALT];
    NSString *checkValue = [PostbeHelper md5_16:checkSeq];
    [param setObject:checkValue forKey:@"checkvalue"];
    
    //添加附加参数
    NSMutableDictionary *additionParamTotal = [[PostbeSetting shareInstance] additionParam];
    [additionParamTotal addEntriesFromDictionary:additionParam];
    [param setObject:[PostbeHelper stringByProcSpecialChar:additionParamTotal] forKey:@"str_array"];
    
    // 将参数转到GET的URL后缀
    NSMutableString *paramSTR = nil;
    for (NSString *k in [param allKeys]){
        if (paramSTR) {
            [paramSTR appendFormat:@"&%@=%@", k, [param objectForKey:k]];
        }else{
            paramSTR = [NSMutableString stringWithFormat:@"%@=%@", k, [param objectForKey:k]];
        }
    }
    CFStringRef cfstr = CFURLCreateStringByAddingPercentEscapes(CFAllocatorGetDefault(),
                                                                (CFStringRef)paramSTR,
                                                                CFSTR("%&"),
                                                                CFSTR("{},: "),
                                                                kCFStringEncodingUTF8);
    NSString* encodeParamSTR = (__bridge NSString*)cfstr;
    NSString *postUrl = [[PostbeSetting shareInstance] postUrl] ? [[PostbeSetting shareInstance] postUrl] :POSTBE_URL_D ;
    NSString* urlString = [NSString stringWithFormat:@"%@?%@", postUrl, encodeParamSTR];
    
#ifndef POSTBE_BATCH_ON
    // 网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithArray:@[@"text/plain", @"text/html"]]];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //发送成功
        NSLog(@"SEND SUCCESS data = %@",encodeParamSTR);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        #ifndef POSTBE_BATCH_ON
        NSLog(@"SEND FAILED INSERT DB data = %@",encodeParamSTR);
        //缓存数据库中
        [[PostbeDB sharedInstance] insertData:encodeParamSTR];
        #endif
    }];
#else
    //缓存数据库中
     NSLog(@"POSTBEMANAGE ON INSERT DB data = %@",encodeParamSTR);
    [[PostbeDB sharedInstance] insertData:encodeParamSTR];
#endif
}


/*!
 *  @author scott.lin, 16-01-27
 *
 *  @brief 批量发送，含有附加信息
 *  @param dataArray   批量发送数据（json字符串数组）
 *  @param delegate 发送结果回调代理
 */
+(void)batchPostbe:(NSMutableArray*)dataArray delegate:(id<PostbeServiceDelegate>)delegate{

    
    
    //test
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (delegate && [delegate respondsToSelector:@selector(onBatchPostbeSuccess)]) {
            [delegate performSelector:@selector(onBatchPostbeSuccess)];
        }
        NSLog(@"BATCH SEND POSTBE COMPLETED ");

    });
    

}





@end

