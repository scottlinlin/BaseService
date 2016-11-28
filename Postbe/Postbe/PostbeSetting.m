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
//
//-(void)initHeadData{
//    // 日期
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    //设置默认值
//    NSString *appAction = @"postbe";
//    NSString *version = @"";
//    NSString *appClient = POSTBE_APP_CLIENT;
//    NSString *appPlatform =  POSTBE_APP_PLATFORM;
//    NSString *appVersion = [CPDeviceUtil bundleVersion];
//    //    NSString *hdserial = [[DeviceIntrospection sharedInstance] uuid];
//    NSString *uid = [[DeviceIntrospection sharedInstance] uuid];
//    NSString *date = [formatter stringFromDate:[NSDate date]];
//    NSString *model = [[DeviceIntrospection sharedInstance] platformName];
//    NSString *merId =  @"";
//    NSString *userNo =  @"";
//    
//    self.headData = [NSMutableDictionary new];
//    [self.headData setObject:appAction forKey:@"act"];
//    [self.headData setObject:version forKey:@"version"];
//    [self.headData setObject:appClient forKey:@"app_client"];
//    [self.headData setObject:appPlatform forKey:@"app_platform"];
//    [self.headData setObject:appVersion forKey:@"app_version"];
//    [self.headData setObject:uid forKey:@"uid"];
//    [self.headData setObject:date forKey:@"datetime"];
//    [self.headData setObject:model forKey:@"model"];
//    [self.headData setObject:merId forKey:@"mer_id"];
//    [self.headData setObject:userNo forKey:@"user_no"];
//}



@end
