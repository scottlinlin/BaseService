//
//  NSString+AES256.m
//  PocTest
//
//  Created by chinapnr on 15/12/24.
//  Copyright © 2015年 iTaa. All rights reserved.
//

#import "NSString+AES256.h"
#import "NSData+AES256.h"
#import "Base64.h"

@implementation NSString(AES256)

-(NSString *) aes256_encrypt:(NSString *)key
{
    //const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //对数据进行加密
    NSData *result = [data aes256_encrypt:key];
    if (result && result.length > 0) {
        return [Base64 base64EncodedStringFrom:result];
    }
    return nil;
}

-(NSString *) aes256_decrypt:(NSString *)key
{
    NSData *data = [Base64 dataWithBase64EncodedString:self];
    
    //对数据进行解密
    NSData* result = [data aes256_decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}
@end