//
//  Helper.m
//  Acquirer
//
//  Created by chinaPnr on 13-7-11.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import "PostbeHelper.h"
#import "SFHFKeychainUtils.h"
#define kKeychainServiceName (@"kcTTY")

#define kReplaceTempStringBackslash @"Ó反斜杠Ò" // OPT+SHIFT+H,K
#define kReplaceTempStringReturn @"Ó换行Ò"      // OPT+SHIFT+K,L

@implementation PostbeHelper

#pragma mark - 加解密相关
+(NSString *)md5_16:(NSString *)str
{
    if (str.length==0) {
        return @"";
    }
    
    const char *cstr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1],
            result[2], result[3],
            result[4], result[5],
            result[6], result[7],
            result[8], result[9],
            result[10], result[11],
            result[12], result[13],
            result[14], result[15]];
}

//32位md5加密
+(NSString *)md5_32:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSString *)base64forData:(NSData*)theData
{
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+(NSData*)base64DataFromString:(NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4] , outbuf[3];
    memset(inbuf, 0, sizeof(inbuf));
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil)
    {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[string UTF8String];
    
    lentext = [string length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true)
    {
        if (ixtext >= lentext)
        {
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z'))
        {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z'))
        {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9'))
        {
            ch = ch - '0' + 52;
        }
        else if (ch == '+')
        {
            ch = 62;
        }
        else if (ch == '=')
        {
            flendtext = true;
        }
        else if (ch == '/')
        {
            ch = 63;
        }
        else
        {
            flignore = true;
        }
        
        if (!flignore)
        {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext)
            {
                if (ixinbuf == 0)
                {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2))
                {
                    ctcharsinbuf = 1;
                }
                else
                {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4)
            {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++)
                {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak)
            {
                break;
            }
        }
    }
    
    return theData;
}

/*!
 *  @author scott.lin, 16-01-28
 *
 *  @brief  将dict参数中的特殊字符做处理，通常用于GET请求时
 *  @param param dic字典
 *  @return 返回处理后的字符串
 */
+ (NSString*)stringByProcSpecialChar:(NSDictionary*)param
{
    // 附加参数
    if (param && param.allKeys.count>0) {
        
        // 1.1 转成json
        NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
        NSString *procString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // 1.2 去非用户输入的回车
        procString = [procString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        // 2.1.1 临时字串替换真正的【\】（避免作为GET参数时本来是一个变成俩）
        if ([procString rangeOfString:@"\\\\"].length > 0) {
            // 单个【\】会显示为【\\】所以【\\】替换成单个的【\】
            procString = [procString stringByReplacingOccurrencesOfString:@"\\\\" withString:kReplaceTempStringBackslash];
        }
        // 2.2.1 转换【回车】
        if ([procString rangeOfString:@"\\n"].length > 0) {
            procString = [procString stringByReplacingOccurrencesOfString:@"\\n" withString:kReplaceTempStringReturn];
        }
        // 2.3 去掉除真正【\】之外的所有转义字符前的'\'（如'\/'）
        procString = [procString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        // 2.1.2 将真正的【\】复原
        if ([procString rangeOfString:kReplaceTempStringBackslash].length > 0) {
            procString = [procString stringByReplacingOccurrencesOfString:kReplaceTempStringBackslash withString:@"\\"];
        }
        // 2.2.2 将回车还原
        if ([procString rangeOfString:kReplaceTempStringReturn].length > 0) {
            procString = [procString stringByReplacingOccurrencesOfString:kReplaceTempStringReturn withString:@"\n"];
        }
        
        // 3.1 正确传&、%符号及后面字符（不能在下面CF转，因为会将正确的&、%连接符也转掉）
        procString = [procString stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
        procString = [procString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        
        // 8.转码空格
        procString = [procString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        return procString;
    }
    
    return @"";
}



@end
