//
//  ThreeViewController.m
//  错误信息截屏
//
//  Created by chinapnr on 16/2/24.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第三页";
    self.view.backgroundColor = [UIColor whiteColor];
 
}

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 上传截图和反馈内容协议方法
 *  @param shotImage  截图
 *  @param optionText 反馈内容
 */
- (void)passShotImage:(UIImage *)shotImage OptionText:(NSString *)optionText
{
    NSLog(@"feedbackImage%@", shotImage);
    NSLog(@"反馈内容:%@", optionText);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
