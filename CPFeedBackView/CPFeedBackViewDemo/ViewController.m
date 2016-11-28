//
//  ViewController.m
//  错误信息截屏
//
//  Created by chinapnr on 16/1/28.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "CPFeedBackView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;               /*!< 表视图 */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"摇一摇";
    // 创建tableview
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

/*!
 *  @author Huibin Guo, 2016/02/17
 *  @brief 创建cell
 *  @param tableView 表视图
 *  @param indexPath cell位置
 *  @return cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.imageView.image = [UIImage imageNamed:@"u=4120729052,2383963756&fm=116&gp=0.jpg"];
    cell.textLabel.text = @"111111";
    return cell;
}

/*!
 *  @author Huibin Guo, 2016/02/17
 *  @brief tableview行高
 *  @param tableView 表视图
 *  @param indexPath 行位置
 *  @return 行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

/*!
 *  @author Huibin Guo, 2016/02/17
 *  @brief 行数
 *  @param tableView 表视图
 *  @param section   分区
 *  @return 行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief tableview点击方法
 *  @param tableView 表视图
 *  @param indexPath 行位置
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

/*!
 *  @author Huibin Guo, 2016/02/26
 *  @brief 提交截图和反馈协议方法
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

@end
