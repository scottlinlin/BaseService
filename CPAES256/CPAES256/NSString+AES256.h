//
//  NSString+AES256.h
//  PocTest
//
//  Created by chinapnr on 15/12/24.
//  Copyright © 2015年 iTaa. All rights reserved.
//

//
//NSString +AES256.h
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



@interface NSString(AES256)

-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;

@end
