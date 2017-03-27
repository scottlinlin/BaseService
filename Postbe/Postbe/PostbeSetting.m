//
//  PostbeSetting.m
//  BatchPosbePoc
//
//  Created by user on 16/2/4.
//  Copyright © 2016年 User. All rights reserved.
//

#import "PostbeSetting.h"


static PostbeSetting *instance = nil;
@implementation PostbeSetting
/*!
 *  @author scott.lin, 16-02-04
 *
 *  @brief 获取PostbeSetting单例
 */
+(instancetype)shareInstance{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!instance) {
            instance = [[[self class] alloc] init];
        }
    });
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        self.headData = [NSMutableDictionary new];
        self.checkKeys = [NSMutableArray new];
        self.additionParam = [NSMutableDictionary new];
    }
    return self;
}


@end
