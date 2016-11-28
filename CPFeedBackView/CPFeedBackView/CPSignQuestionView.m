//
//  CPSignQuestionView.m
//  错误信息截屏
//
//  Created by chinapnr on 16/1/28.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import "CPSignQuestionView.h"
#import "CPShakeAndCutterView.h"

NSString *const TouchBeganNotification = @"TouchBeganNotification";     /*!< 手势开始通知 */
NSString *const TouchMovedNotification = @"TouchMovedNotification";     /*!< 手势移动通知 */
NSString *const TouchEndNotification = @"TouchEndNotification";         /*!< 手势停止通知 */

@implementation CPSignQuestionView

/*!
 *  @author Huibin Guo, 2016/02/18
 *  @brief 初始化方法
 *  @param frame 尺寸
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [lblSignature removeFromSuperview];
    }
    return self;
}

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 触摸手势开始
 *  @param touches 触摸手势
 *  @param event   触摸事件
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    // 手势开始发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:TouchBeganNotification object:self];
}

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 手势移动
 *  @param touches 触摸手势
 *  @param event   手势移动事件
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    // 手势移动发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:TouchMovedNotification object:self];
}

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 手势结束
 *  @param touches 触摸手势
 *  @param event   手势结束事件
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 手势停止发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:TouchEndNotification object:self];
}

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 手势中断
 *  @param touches 触摸手势
 *  @param event   手势中断事件
 */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

@end
