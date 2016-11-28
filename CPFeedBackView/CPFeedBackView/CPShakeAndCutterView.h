//
//  ShakeAndCutterView.h
//  错误信息截屏
//
//  Created by chinapnr on 16/1/26.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPSignQuestionView.h"
/*!
 *  @author Huibin Guo, 2016/02/25
 *  @brief 传递截图和反馈信息代理
 */
@protocol CommitQuestionDelegate <NSObject>

/*!
 *  @author Huibin Guo, 2016/02/25
 *  @brief 传递截图和反馈信息代理方法
 *  @param shotImage  截图
 *  @param optionText 反馈信息
 */
- (void)passShotImage:(UIImage *)shotImage OptionText:(NSString *)optionText;

@end

/*!
 *  @author Huibin Guo, 2016/01/28
 *  @brief 摇一摇截图页面
 */
@interface CPShakeAndCutterView : UIView <UITextViewDelegate>

@property (nonatomic, strong) CPSignQuestionView *signatureView;
@property (nonatomic, strong) UIImageView *bottomView;              /*!< 底部图片 */
@property (nonatomic, strong) UIButton *paintBtn;                   /*!< 画线按钮 */
@property (nonatomic, strong) UIButton *clearBtn;                   /*!< 清除按钮 */
@property (nonatomic, strong) UIImageView *line;                    /*!< 分割线 */
@property (nonatomic, strong) UIImageView *bottomLine;              /*!< 按钮下划线 */
@property (nonatomic, strong) UIButton *editBtn;                    /*!< 弹出编辑框按钮 */
@property (nonatomic, strong) UIImageView *backView;                /*!< 导航栏图片 */
@property (nonatomic, strong) UILabel *queTitle;                    /*!< 题目 */
@property (nonatomic, strong) UIButton *leftBtn;                    /*!< 退出按钮 */
@property (nonatomic, strong) UIButton *rightBtn;                   /*!< 提交按钮 */
@property (nonatomic, strong) UITextView *optionText;               /*!< 输入框 */
@property (nonatomic, strong) UIView *blackView;                    /*!< 黑色半透明 */
@property (nonatomic, strong) UILabel *placeholder;                 /*!< 输入框占位符 */
@property (nonatomic, strong) NSString *string;
@property (nonatomic, assign) NSInteger statusBar;                  /*!< 状态栏颜色 */
@property (nonatomic, strong) NSBundle *bundle;

@property (nonatomic, assign) id<CommitQuestionDelegate>delegate;   /*!< 设置传递截图和反馈信息代理 */

@end
