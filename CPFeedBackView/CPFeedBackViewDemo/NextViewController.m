//
//  NextViewController.m
//  错误信息截屏
//
//  Created by chinapnr on 16/2/24.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import "NextViewController.h"
#import "ThreeViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 摇一摇手势结束
 *  @param motion 摇一摇手势
 *  @param event  手势结束触发事件
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"!!!!!!!!!!!");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第二页";
    // 创建跳转下一页按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 60, 30);
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 跳转到下一页按钮点击方法
 */
- (void)push
{
    ThreeViewController *threeVC = [[ThreeViewController alloc] init];
    [self.navigationController pushViewController:threeVC animated:YES];
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
