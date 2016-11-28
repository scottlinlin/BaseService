//
//  NSData+AES256.h
//  PocTest
//
//  Created by chinapnr on 15/12/24.
//  Copyright © 2015年 iTaa. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSData(AES256)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end
