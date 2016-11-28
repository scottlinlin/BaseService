//
//  UIViewController+ShakeFeedback.m
//  错误信息截屏
//
//  Created by chinapnr on 16/1/26.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import "UIViewController+ShakeFeedback.h"
#import <QuartzCore/QuartzCore.h>
#import "CPFeedBackView.h"

BOOL sEnableShake = YES;

/*!
 *  @author Huibin Guo, 2016/02/18
 *  @brief 视图控制器摇一摇扩展类
 */
@implementation UIViewController (ShakeFeedback)

/*!
 *  @author LeiQiao, 16-03-01
 *  @brief 是否允许全局摇一摇弹出反馈窗，默认允许
 *  @param enableShake 是否允许摇一摇
 */
+(void) enableShakeFeedback:(BOOL)enableShake
{
    sEnableShake = enableShake;
}

#pragma mark - 摇一摇动作处理

/*!
 *  @author Huibin Guo, 2016/01/27
 *  @brief 摇一摇结束
 *  @param motion 摇一摇动作
 *  @param event  触发事件
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // 调用显示提示框类方法并设置代理人
    if( sEnableShake )
    {
        [CPFeedBackView showFeedBackViewWithDelegate:(id<CommitQuestionDelegate>)self];
        sEnableShake = NO;
    }
}

@end
