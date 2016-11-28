//
//  UIViewController+ShakeFeedback.h
//  错误信息截屏
//
//  Created by chinapnr on 16/1/26.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  @author Huibin Guo, 2016/01/28
 *  @brief 视图控制器摇一摇扩展类
 */
@interface UIViewController (ShakeFeedback)

/*!
 *  @author LeiQiao, 16-03-01
 *  @brief 是否允许全局摇一摇弹出反馈窗，默认允许
 *  @param enableShake 是否允许摇一摇
 */
+(void) enableShakeFeedback:(BOOL)enableShake;

@end
