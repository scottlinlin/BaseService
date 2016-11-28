//
//  UIViewController+Chinapnr.m
//

#import "UIViewController+Chinapnr.h"


@implementation UIViewController (Chinapnr)


UIColor *titleColor = nil;
UIView *statusBarView = nil;
NSDictionary *attributes = nil;
+(UIView *) sharedStatusBarView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                 -20,
                                                                 [UIScreen mainScreen].bounds.size.width,
                                                                 20)];
    });
    return statusBarView;
}

/*!
 *  @author chunying.jia, 16-04-21
 *  @brief setNavigationBarColor
 *  @param color UIColor
 *  @param enabled if set enable title color will auto set to black or white 
 */
-(void) setNavigationBarTintColor:(UIColor *)color AutoFitTitleColor:(BOOL)enabled{
    statusBarView = [UIViewController sharedStatusBarView];
    // 设置状态栏
    statusBarView.backgroundColor = color;
    [self.navigationController.navigationBar addSubview:statusBarView];
    self.navigationController.navigationBar.backgroundColor = color;
    // 根据背景颜色自动设置title的颜色
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    if (red < 128.0 / 255.0 || green < 128.0 / 255.0|| blue < 128.0 / 255.0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        titleColor = [UIColor whiteColor];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        titleColor = [UIColor colorWithRed:51.0/255.0
                                     green:51.0/255.0
                                      blue:51.0/255.0
                                     alpha:1.0];
    }
    if (enabled) {
        [self setNavigationBarTitleColor:titleColor];
    }
}

-(void)setNavigationBarTitleColor:(UIColor *)titleColor{
    attributes=[NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

#pragma mark
#pragma mark member functions

-(void) removeNavigationBarBackground
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        // 子视图添加至数组
        NSArray *list=self.navigationController.navigationBar.subviews;
        // 遍历子视图数组
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
        
                imageView.hidden=YES;
            }
        }
        [self setNavigationBarTintColor:[UIColor whiteColor] AutoFitTitleColor:YES];
    }

}

-(void) setLeftButtonTitle:(NSString*)leftButtonTitle
{
    if( !leftButtonTitle )
    {
        // 使用隐藏的View来设置按钮
        UIView* emptyV = [[UIView alloc] init];
        emptyV.hidden = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:emptyV];
    }
    else
    {
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:leftButtonTitle
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(leftButtonDidClicked:)];
        self.navigationItem.leftBarButtonItem = button;
    }
}

-(void) setLeftButtonImage:(UIImage*)leftButtonImage
{
    if( !leftButtonImage )
    {
        // 使用隐藏的View来设置按钮
        UIView* emptyV = [[UIView alloc] init];
        emptyV.hidden = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:emptyV];
    }
    else
    {
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithImage:leftButtonImage
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(leftButtonDidClicked:)];
        self.navigationItem.leftBarButtonItem = button;
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1];
        [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
}

-(void) setRightButtonTitle:(NSString*)rightButtonTitle
{
    if( !rightButtonTitle )
    {
        // 使用隐藏的View来设置按钮
        UIView* emptyV = [[UIView alloc] init];
        emptyV.hidden = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:emptyV];
    }
    else
    {
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:rightButtonTitle
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(rightButtonDidClicked:)];
        self.navigationItem.rightBarButtonItem = button;
    }
}

-(void) setRightButtonImage:(UIImage*)rightButtonImage
{
    if( !rightButtonImage )
    {
        // 使用隐藏的View来设置按钮
        UIView* emptyV = [[UIView alloc] init];
        emptyV.hidden = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:emptyV];
    }
    else
    {
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithImage:rightButtonImage
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(rightButtonDidClicked:)];
        self.navigationItem.rightBarButtonItem = button;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1];
    }
}

-(void) leftButtonDidClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) rightButtonDidClicked:(id)sender
{
    NSAssert(NO, @"subclass MUST override (rightButtonDidClicked:)");
}

- (void) setNavigationBarTypeWithColor:(UIColor *)color translucent:(BOOL)translucent{
    self.navigationController.navigationBar.translucent = translucent;
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 64);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (UIImageView *)navBarHairlineImageView{
    return [self findHairlineImageViewUnder:self.navigationController.navigationBar];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
