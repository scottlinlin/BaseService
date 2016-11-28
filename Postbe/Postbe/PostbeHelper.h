//
//  Helper.h
//  Acquirer
//
//  Created by chinaPnr on 13-7-11.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
//#import <UIKit/UIKit.h>


@interface PostbeHelper : NSObject

#pragma mark - 文件相关
#define AppDocumentsPath(filename)([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:filename])

#pragma mark - 加解密相关
/**
 MD5加密
 @param str 输入初始参数
 @returns 加密后字符串
 */
+(NSString *)md5_16:(NSString *)str;

//32位md5加密
+(NSString *)md5_32:(NSString *)str;

/**
 将NSData转为Base64字符串
 @param theData 输入数据
 @returns 输出Base64编码字符串
 */
+(NSString*)base64forData:(NSData*)theData;

/**
 将base64字符串转换为NSData
 @param string base64字符串
 @returns 返回NSData
 */
+(NSData*)base64DataFromString:(NSString *)string;

/*!
 *  @author scott.lin, 16-01-28
 *
 *  @brief  将dict参数中的特殊字符做处理，通常用于GET请求时
 *  @param param dic字典
 *  @return 返回处理后的字符串
 */
+ (NSString*)stringByProcSpecialChar:(NSDictionary*)param;


@end
