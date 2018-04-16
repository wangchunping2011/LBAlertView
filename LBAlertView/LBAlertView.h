//
//  LBAlertView.h
//  
//
//  Created by lib on 2018/4/11.
//  Copyright © 2018年 lib. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBAlertView;

typedef void(^LBAlertBlock)(LBAlertView *alertView);

@interface LBAlertView : UIView
// 初始化
+ (instancetype)alertViewWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelAction:(LBAlertBlock)cancel otherTitle:(NSString *)otherTitle otherAction:(LBAlertBlock)other;
// 显示
- (void)show;

// message文字颜色  默认: 黑色
@property(nonatomic, strong) UIColor *messageColor;
// 提示框颜色    默认: 白色
@property(nonatomic, strong) UIColor *barTintColor;
// 分割线颜色    默认: 亮灰色
@property(nonatomic, strong) UIColor *separationColor;

// 圆角   默认: 10.f
@property(nonatomic, assign) CGFloat cornerRadius;

// 设置取消文字状态颜色   默认: 亮灰色
- (void)setCancelTitleColor:(UIColor *)color stats:(UIControlState)stats;
// 设置其他文字状态颜色   默认: 红色
- (void)setOtherTitleColor:(UIColor *)color stats:(UIControlState)stats;

@end
