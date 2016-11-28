//
//  ShakeAndCutterView.m
//  错误信息截屏
//
//  Created by chinapnr on 16/1/26.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import "CPShakeAndCutterView.h"
#import "UIViewController+ShakeFeedback.h"

@implementation CPShakeAndCutterView

#pragma mark - init & dealloc
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 初始化方法
 *  @param frame 尺寸大小
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景色为白色，截屏闪一下的效果
        self.backgroundColor = [UIColor whiteColor];
        
        // 创建画图view，并把截图设置为背景图片
        self.signatureView = [[CPSignQuestionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.frame.size.height)];
        // 截屏图片为背景，用来画图
        self.signatureView.backgroundColor = [UIColor colorWithPatternImage:[self screenShot]];
        [self addSubview:self.signatureView];
        // 截屏闪一下的效果
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            // 设置透明度为透明
            self.signatureView.alpha = 0;
            
        } completion:^(BOOL finished) {
            // 设置透明度为不透明
            self.signatureView.alpha = 1;
            // 自定义导航栏和底部按钮动画
            [UIView animateWithDuration:0.4 animations:^{
                // 实现动画效果
                self.backView.frame = CGRectMake(0, 0, self.frame.size.width, 64);
                self.paintBtn.frame = CGRectMake(self.frame.size.width / 4 - 20, self.frame.size.height - 38, 30, 30);
                self.editBtn.frame = CGRectMake(self.frame.size.width / 3 * 2 + 10, self.frame.size.height - 38, 30, 30);
                self.queTitle.frame = CGRectMake((self.frame.size.width - 80) / 2, 24, 80, 30);
                self.leftBtn.frame = CGRectMake(10, 25, 50, 30);
                self.rightBtn.frame = CGRectMake(self.frame.size.width - 60, 25, 50, 30);
                self.bottomView.frame = CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50);
                self.line.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height - 37, 1, 28);
                
            }];
            
        }];
        
        // 获取状态栏颜色，若不是白色则改为白色
        self.statusBar = [UIApplication sharedApplication].statusBarStyle;
        if (self.statusBar != 1) {
            // 设置状态栏为白色
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }
        // 创建导航栏和底部按钮
        [self createNavigationAndBottomBtn];
        
        // 手势移动注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNavigationAndBottomBtn) name:TouchMovedNotification object:nil];
        // 手势停止移动注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationAndBottomBtn) name:TouchEndNotification object:nil];
        // 手势开始注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideNavigationAndBottomBtn) name:TouchBeganNotification object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 截屏处理
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 截屏
 *  @return 截屏图片
 */
- (UIImage *)screenShot
{
//    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    // 修复iOS7不能截取当前页面的问题
    UIWindow *screenWindow = [[[UIApplication sharedApplication] delegate] window];
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 将截屏图片保存到系统相册
//    UIImageWriteToSavedPhotosAlbum(screenShot, self, nil, nil);
    return screenShot;
}

#pragma mark - 创建导航栏和底部按钮
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 创建导航栏和底部按钮
 */
- (void)createNavigationAndBottomBtn
{
    // 创建导航栏view
    self.backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    self.backView.backgroundColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1];
    // 开启用户交互
    self.backView.userInteractionEnabled = YES;
    [self addSubview:self.backView];
    
    // 设置标题
    self.queTitle = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 80) / 2, 0, 80, 0)];
    self.queTitle.text = @"反馈问题";
    [self.queTitle setFont:[UIFont systemFontOfSize:19]];
    self.queTitle.textColor = [UIColor whiteColor];
    [self.backView addSubview:self.queTitle];
    
    // 创建退出按钮
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(10, 0, 50, 0);
    [self.leftBtn setTitle:@"退出" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(exitBack) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.leftBtn];
    
    // 创建提交按钮
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(self.frame.size.width - 60, -10, 50, 0);
    [self.rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1] forState:UIControlStateNormal];
    self.rightBtn.enabled = NO;
    [self.rightBtn addTarget:self action:@selector(commitImage) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.rightBtn];
    
    // 底部按钮背景图
    self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];
    self.bottomView.backgroundColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1];
    self.bottomView.userInteractionEnabled = YES;
    [self addSubview:self.bottomView];
    
    // 获取bundle文件中的图片资源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CPFeedBackView" ofType:@"bundle"];
    self.bundle = [NSBundle bundleWithPath:path];
    
    NSString *paintBtnPath = [self.bundle pathForResource:@"iconfont-bi3" ofType:@"png"];
    NSString *clearBtnPath = [self.bundle pathForResource:@"iconfont-shanchu" ofType:@"png"];
    NSString *editBtnPath = [self.bundle pathForResource:@"iconfont-t" ofType:@"png"];
    
    // 创建底部画线按钮
    self.paintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.paintBtn.frame = CGRectMake(self.frame.size.width / 4 - 20, self.frame.size.height, 30, 0);
    self.paintBtn.backgroundColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1];
    
    [self.paintBtn setImage:[UIImage imageWithContentsOfFile:paintBtnPath] forState:UIControlStateNormal];
    [self addSubview:self.paintBtn];
    
    // 底部清除按钮
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clearBtn.frame = CGRectMake(self.frame.size.width / 2 - 20, self.frame.size.height - 100, 40, 40);
    self.clearBtn.backgroundColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1];
    self.clearBtn.layer.cornerRadius = 5.0f;
    self.clearBtn.alpha = 0.7;
    self.clearBtn.hidden = YES;
    [self.clearBtn setImage:[UIImage imageWithContentsOfFile:clearBtnPath] forState:UIControlStateNormal];
    [self.clearBtn addTarget:self action:@selector(clearImageBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clearBtn];
    
    // 创建底部编辑框按钮
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.frame = CGRectMake(self.frame.size.width / 3 * 2 + 10, self.frame.size.height, 30, 0);
    [self.editBtn setImage:[UIImage imageWithContentsOfFile:editBtnPath] forState:UIControlStateNormal];
    self.editBtn.backgroundColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1];
    [self.editBtn addTarget:self action:@selector(editBtnDidPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editBtn];
    
    // 底部按钮分割线
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, self.frame.size.height - 8, 1, 0)];
    self.line.backgroundColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1];
    [self addSubview:self.line];
    
    // 按钮下划线
    self.bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 - 30, self.frame.size.height - 2, 50, 2)];
    self.bottomLine.backgroundColor = [UIColor colorWithRed:0.2 green:0.59 blue:0.96 alpha:1];
    [self addSubview:self.bottomLine];
}

#pragma mark - 退出按钮点击方法
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 退出按钮点击方法
 */
- (void)exitBack
{
    // 设置状态栏为截图前颜色
    [UIApplication sharedApplication].statusBarStyle = self.statusBar;
    // 删除当前画图view
    [self removeFromSuperview];
    [UIViewController enableShakeFeedback:YES];
}

#pragma mark - 提交按钮点击方法
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 提交按钮点击方法
 */
- (void)commitImage
{
    // 获取截屏后被标记的图片
    UIImage* feedbackImage = [self.signatureView getSignatureImage];
    // 将编辑好的图片保存至相册
//    UIImageWriteToSavedPhotosAlbum(feedbackImage, self, nil, nil);
    NSString* feedbackString = self.optionText.text;
    // 判断代理方法是否响应
    if (self.delegate && [self.delegate respondsToSelector:@selector(passShotImage:OptionText:)]) {
        // 提交被标记的图片和输入框中的内容
        [self.delegate passShotImage:feedbackImage OptionText:feedbackString];
    }
    // 提交后退出反馈页
    [self exitBack];
    [UIViewController enableShakeFeedback:YES];
}

#pragma mark - 清除按钮点击方法
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 清除画线
 */
- (void)clearImageBtnPressed
{
    // 清除画的线
    [self.signatureView clearSignature];
    // 画线被清除后隐藏清除按钮
    self.clearBtn.hidden = YES;
    // 如果输入框为空按钮不能点击
    if (self.string.length == 0) {
        [self.rightBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1] forState:UIControlStateNormal];
        self.rightBtn.enabled = NO;
    }
}

#pragma mark - 弹出textview
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 编辑内容按钮点击方法
 */
- (void)editBtnDidPressed
{
    // 按钮下划线滑动效果
    [UIView animateWithDuration:0.4 animations:^{
        self.bottomLine.frame = CGRectMake(self.frame.size.width / 4 - 25 + self.frame.size.width / 2, self.frame.size.height - 2, 50, 1);
    }];
    
    // 覆盖的半透明黑底
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64)];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha = 0.5;
    [self addSubview:self.blackView];
    
    // 添加手势回收键盘
    UITapGestureRecognizer *gestureTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self addGestureRecognizer:gestureTap];
    
    // 输入框
    self.optionText = [[UITextView alloc] initWithFrame:CGRectMake(10, 80, self.frame.size.width - 20, 180)];
    self.optionText.backgroundColor = [UIColor whiteColor];
    [self.optionText setFont:[UIFont systemFontOfSize:14]];
    self.optionText.text = self.string;
    self.optionText.delegate = self;
    [self.optionText.layer setCornerRadius:10];
    [self addSubview:self.optionText];
    
    // 输入框占位符
    self.placeholder = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 100, 20)];
    [self.placeholder setFont:[UIFont systemFontOfSize:14]];
    self.placeholder.text = @"请输入您的反馈";
    self.placeholder.enabled = NO;
    [self.optionText addSubview:self.placeholder];
    
    // 点击按钮弹出键盘
    [self.optionText becomeFirstResponder];
    // 输入框弹出，退出按钮不可点击
    self.leftBtn.enabled = NO;
    [self.leftBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1] forState:UIControlStateNormal];
}

#pragma mark - 隐藏textview
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 点击空白处隐藏输入框
 */
- (void)tapGesture
{
    // 底部按钮下划线动画效果
    [UIView animateWithDuration:0.4 animations:^{
        self.bottomLine.frame = CGRectMake(self.frame.size.width / 4 - 30, self.frame.size.height - 2, 50, 1);
    }];
    // 回收键盘
    [self.optionText resignFirstResponder];
    self.optionText.hidden = YES;
    [self.blackView removeFromSuperview];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.enabled = YES;
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.enabled = YES;
}

#pragma mark - 通知方法
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 隐藏自定义导航栏和底部按钮
 */
- (void)hideNavigationAndBottomBtn
{
    self.backView.hidden = YES;
    self.paintBtn.hidden = YES;
    self.editBtn.hidden = YES;
    self.bottomView.hidden = YES;
    self.clearBtn.hidden = YES;
    self.line.hidden = YES;
    self.bottomLine.hidden = YES;
    // 屏幕被点击后提交按钮可用
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.enabled = YES;
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 显示自定义导航栏和底部按钮
 */
- (void)showNavigationAndBottomBtn
{
    self.backView.hidden = NO;
    self.paintBtn.hidden = NO;
    self.editBtn.hidden = NO;
    self.bottomView.hidden = NO;
    self.clearBtn.hidden = NO;
    self.line.hidden = NO;
    self.bottomLine.hidden = NO;
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark - textview协议方法
/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 输入框内容改变
 *  @param textView 输入框
 */
- (void)textViewDidChange:(UITextView *)textView
{
    // 输入框内容为空时有占位符
    if (textView.text.length == 0) {
        self.placeholder.text = @"请输入您的反馈";
    } else {
        self.placeholder.text = @"";
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.enabled = YES;
    }
}

/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 输入框开始被编辑
 *  @param textView 输入框
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // 开始编辑时内容为空则显示占位符
    if (textView.text.length == 0) {
        self.placeholder.text = @"请输入您的反馈";
    } else {
        self.placeholder.text = @"";
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.enabled = YES;
    }
}

/*!
 *  @author Huibin Guo, 2016/01/26
 *  @brief 输入框停止编辑
 *  @param textView 输入框
 */
- (void)textViewDidEndEditing:(UITextView *)textView
{
    // 输入框再次打开后还显示之前的未删除的内容
    self.string = textView.text;
}

@end