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
    
    
    
    // 附加参数
//    if (userNo.length>0) {
//        NSMutableDictionary* additionParamTemp = [[NSMutableDictionary alloc] init];
//        if (additonParam) {
//            additionParamTemp = [additonParam mutableCopy];
//        }
//        [additionParamTemp setObject:userNo forKey:@"userNo"];
//        additonParam = [additionParamTemp copy];
//    }
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
    NSString* urlString = [NSString stringWithFormat:@"%@?%@", POSTBE_URL, encodeParamSTR];
    
#ifndef POSTBE_ON
    // 网络请求
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithArray:@[@"text/plain", @"text/html"]]];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SEND SUCCESS data = %@",encodeParamSTR);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //缓存数据库中
        NSLog(@"SEND FAILED INSERT DB data = %@",encodeParamSTR);
        [[PostbeDB sharedInstance] insertData:encodeParamSTR];
    }];
#else
    //缓存数据库中
     NSLog(@"POSTBEMANAGE ON INSERT DB data = %@",encodeParamSTR);
    [[PostbeDB sharedInstance] insertData:encodeParamSTR];
#endif
}


///*!
// *  @author scott.lin, 16-01-25
// *
// *  @brief 获取keychain中的Postbe设备id
// *  @return Postbe设备id
// */
//+(NSString *)getPostbeUID{
//    //NSString *uid = [Helper getValueByKey:POSTBE_UID];
//    NSString *uid = [Helper getValueFromKeyChain:POSTBE_UID];
//    //兼容之前的uid（从userdefault获取）
//    if (uid.length==0) {
//        uid = [Helper getValueByKey:POSTBE_UID];
//    }
//    //postbe没有缓存，从网络接口获取uid
//    if ([Helper stringNullOrEmpty:uid] || [uid isEqualToString:DM_DEFAULT_VALUE]) {
//        [PostbeService getPostbeUIDFromNetQuest];
//        return @"";
//    }
//    return uid;
//}

///*!
// *  @author scott.lin, 16-01-25
// *
// *  @brief 从网络接口获取Postbe设备id
// */
//+(void)getPostbeUIDFromNetQuest{
//    
//    NSDictionary *param = @{@"act" : @"get_uid",
//                            @"key" : @"TTYFUND-CHINAPNR",
//                            @"mac_id" : [[DeviceIntrospection sharedInstance] uuid]};
//    
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:POSTBE_URL]];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithArray:@[@"text/plain", @"text/html"]]];
//    
//    [manager GET:@""
//      parameters:param
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSDictionary *body = responseObject;
//             if (DictNotNilAndEqualsValue(body, RESPONSE_CODE, @"1")) {
//                 //                 [Helper saveValue:[body valueForKey:POSTBE_UID] forKey:POSTBE_UID];
//                 [Helper saveValueToKeyChain:[body valueForKey:POSTBE_UID] forKey:POSTBE_UID];
//             }
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             
//         }
//     ];
//}
//
//
//BOOL  DictNotNilAndEqualsValue(id dict, NSString *k, NSString *value){
//    if ( DictNotNil(dict, k) && [[[dict valueForKey:k] description] isEqualToString:value]) {
//        return YES;
//    }
//    return NO;
//}
//
//BOOL  DictNotNil(id dict, NSString *k){
//    if (dict!=nil && [dict isKindOfClass:[NSDictionary class]] &&
//        [dict objectForKey:k]!=nil && [dict objectForKey:k]!=[NSNull null]) {
//        return YES;
//    }
//    return NO;
//}
//
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
    

    NSString *urlString;
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithArray:@[@"text/plain", @"text/html"]]];
//    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        // post成功
//        if (((NSNumber*)[responseObject objectForKey:@"return_code"]).intValue == 1) {
//            if (delegate && [delegate respondsToSelector:@selector(onBatchPostbeSuccess)]) {
//                [delegate performSelector:@selector(onBatchPostbeSuccess)];
//            }
//        }
//        else{
//            if (delegate && [delegate respondsToSelector:@selector(onBatchPostbeFail)]) {
//                [delegate performSelector:@selector(onBatchPostbeFail)];
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (delegate && [delegate respondsToSelector:@selector(onBatchPostbeFail)]) {
//            [delegate performSelector:@selector(onBatchPostbeFail)];
//        }
//    }];
}





@end

