//
//  CPFeedBackView.m
//  错误信息截屏
//
//  Created by chinapnr on 16/2/26.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import "CPFeedBackView.h"
#import "AlertViewMethod.h"
#import "UIViewController+ShakeFeedback.h"

@implementation CPFeedBackView

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 显示提示框并传代理
 *  @param commitDelegate 上传截图和反馈内容代理
 */
+ (void)showFeedBackViewWithDelegate:(id<CommitQuestionDelegate>)commitDelegate
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 创建提示框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认要反馈问题吗？" message:@"摇一摇就会触发截图反馈问题的功能哦" preferredStyle:UIAlertControllerStyleAlert];
        // alertview取消按钮
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [UIViewController enableShakeFeedback:YES];
        }];
        // alertview确定按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 点击确定按钮显示问题反馈页面
            CPShakeAndCutterView *shakeView = [[CPShakeAndCutterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            // 设置代理人
            shakeView.delegate = commitDelegate;
            // 添加视图
            [[UIApplication sharedApplication].keyWindow addSubview:shakeView];
            
        }];
        // 添加按钮
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        // 显示提示框
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    } else {
        static AlertViewMethod *method = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            method = [[AlertViewMethod alloc] init];
        });
        method.commitDelegate = commitDelegate;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认要反馈问题吗？" message:@"摇一摇就会触发截图反馈问题的功能哦" delegate:method cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

@end
