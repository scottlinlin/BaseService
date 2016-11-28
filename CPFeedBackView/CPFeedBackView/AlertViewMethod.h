//
//  AlertViewMethod.h
//  CPFeedBackViewDemo
//
//  Created by chinapnr on 16/3/3.
//  Copyright © 2016年 chinapnr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CPShakeAndCutterView.h"

@interface AlertViewMethod : NSObject<UIAlertViewDelegate, CommitQuestionDelegate>

@property (nonatomic, assign) id<CommitQuestionDelegate>commitDelegate;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
