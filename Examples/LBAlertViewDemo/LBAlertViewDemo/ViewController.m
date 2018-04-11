//
//  ViewController.m
//  LBAlertViewDemo
//
//  Created by meilizu on 2018/4/11.
//  Copyright © 2018年 lib. All rights reserved.
//

#import "ViewController.h"
#import "LBAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onClickButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        LBAlertView *alertView = [LBAlertView alertViewWithMessage:@"吃了吗?" cancelTitle:@"没有" cancelAction:^(LBAlertView *alertView) {
            NSLog(@"点击没有");
        } otherTitle:@"吃了" otherAction:^(LBAlertView *alertView) {
            NSLog(@"点击吃了");
        }];
        alertView.cornerRadius = 15;
        alertView.messageColor = [UIColor redColor];
        alertView.separationColor = [UIColor blackColor];
        alertView.barTintColor = [UIColor darkGrayColor];
        [alertView setCancelTitleColor:[UIColor whiteColor] stats:UIControlStateNormal];
        [alertView setCancelTitleColor:[UIColor redColor] stats:UIControlStateHighlighted];
        [alertView setOtherTitleColor:[UIColor redColor] stats:UIControlStateNormal];
        [alertView setOtherTitleColor:[UIColor whiteColor] stats:UIControlStateHighlighted];
        [alertView show];
    }else {
        [[LBAlertView alertViewWithMessage:@"吃了吗?" cancelTitle:@"没有" cancelAction:^(LBAlertView *alertView) {
            NSLog(@"点击没有");
        } otherTitle:@"吃了" otherAction:^(LBAlertView *alertView) {
            NSLog(@"点击吃了");
        }] show];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
