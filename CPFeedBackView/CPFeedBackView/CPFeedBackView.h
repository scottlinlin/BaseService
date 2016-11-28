//
//  CPFeedBackView.h
//  错误信息截屏
//
//  Created by chinapnr on 16/2/26.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPShakeAndCutterView.h"
/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 显示提示框
 */
@interface CPFeedBackView : NSObject<UIAlertViewDelegate>

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 显示提示框并传代理
 *  @param commitDelegate 上传截图和反馈内容代理
 */
+ (void)showFeedBackViewWithDelegate:(id<CommitQuestionDelegate>)commitDelegate;

@end
