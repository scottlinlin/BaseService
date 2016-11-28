//
//  AlertViewMethod.m
//  CPFeedBackViewDemo
//
//  Created by chinapnr on 16/3/3.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import "AlertViewMethod.h"

@implementation AlertViewMethod

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        // 点击确定按钮显示问题反馈页面
        CPShakeAndCutterView *shakeView = [[CPShakeAndCutterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        // 设置代理人
        shakeView.delegate = self.commitDelegate;
        // 添加视图
        [[[[UIApplication sharedApplication] delegate] window] addSubview:shakeView];
    }
}

@end
