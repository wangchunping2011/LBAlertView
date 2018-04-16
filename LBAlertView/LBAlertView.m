//
//  LBAlertView.m
//
//
//  Created by lib on 2018/4/11.
//  Copyright © 2018年 lib. All rights reserved.
//

#import "LBAlertView.h"
#import <Masonry/Masonry.h>
#define kScale 0.6f

@interface LBAlertView()
@property(nonatomic, strong) UILabel *messageLabel;
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic, strong) UIButton *otherButton;
@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) UIView *separationLine1;
@property(nonatomic, strong) UIView *separationLine2;

@property(nonatomic, strong) UIWindow *keyWindow;

@property(nonatomic, copy) LBAlertBlock cancelBlcok;
@property(nonatomic, copy) LBAlertBlock otherBlock;
@end

@implementation LBAlertView
#pragma mark -- lazy --
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.layer.cornerRadius = 10.f;
        [_backgroundView addSubview:self.messageLabel];
        [_backgroundView addSubview:self.cancelButton];
        [_backgroundView addSubview:self.otherButton];
        [_backgroundView addSubview:self.separationLine1];
        [_backgroundView addSubview:self.separationLine2];
    }
    return _backgroundView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:17];
    }
    return _messageLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(onClickCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)otherButton {
    if (!_otherButton) {
        _otherButton = [[UIButton alloc] init];
        [_otherButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_otherButton addTarget:self action:@selector(onClickOther:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherButton;
}

- (UIView *)separationLine1 {
    if (!_separationLine1) {
        _separationLine1 = [[UIView alloc] init];
        _separationLine1.backgroundColor = [UIColor lightGrayColor];
    }
    return _separationLine1;
}

- (UIView *)separationLine2 {
    if (!_separationLine2) {
        _separationLine2 = [[UIView alloc] init];
        _separationLine2.backgroundColor = [UIColor lightGrayColor];
    }
    return _separationLine2;
}

- (UIWindow *)keyWindow {
    if (!_keyWindow) {
        _keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _keyWindow;
}

#pragma mark -- setter --
- (void)setMessageColor:(UIColor *)messageColor {
    _messageColor = messageColor;
    self.messageLabel.textColor = messageColor;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    self.backgroundView.backgroundColor = barTintColor;
}

- (void)setSeparationColor:(UIColor *)separationColor {
    _separationColor = separationColor;
    self.separationLine1.backgroundColor = separationColor;
    self.separationLine2.backgroundColor = separationColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.backgroundView.layer.cornerRadius = cornerRadius;
}

- (void)setCancelTitleColor:(UIColor *)color stats:(UIControlState)stats {
    [self.cancelButton setTitleColor:color forState:stats];
}

- (void)setOtherTitleColor:(UIColor *)color stats:(UIControlState)stats {
    [self.otherButton setTitleColor:color forState:stats];
}

#pragma mark -- init --
- (instancetype)initWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherTitle {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [self addSubview:self.backgroundView];
        [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        [self.otherButton setTitle:otherTitle forState:UIControlStateNormal];
        self.messageLabel.text = message;
    }
    return self;
}

+ (instancetype)alertViewWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelAction:(LBAlertBlock)cancel otherTitle:(NSString *)otherTitle otherAction:(LBAlertBlock)other {
    LBAlertView *alertView = [[LBAlertView alloc] initWithMessage:message cancelTitle:cancelTitle otherTitle:otherTitle];
    alertView.cancelBlcok = cancel;
    alertView.otherBlock = other;
    return alertView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self).offset(50);
        make.right.equalTo(self).offset(-50);
        make.height.mas_equalTo(120);
    }];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView).multipliedBy(kScale);
    }];
    [_separationLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backgroundView);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.messageLabel);
    }];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.backgroundView);
        make.width.equalTo(self.backgroundView).multipliedBy(0.5);
        make.height.equalTo(self.backgroundView).multipliedBy(1-kScale);
    }];
    [_separationLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.cancelButton);
        make.width.mas_equalTo(0.5);
        make.right.equalTo(self.cancelButton);
    }];
    [_otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.cancelButton);
        make.right.equalTo(self.backgroundView);
    }];
}

- (void)show {
    [self.keyWindow addSubview:self];
    [self.keyWindow bringSubviewToFront:self];
}

#pragma mark -- action --
- (void)onClickCancel:(UIButton *)button {
    if (self.cancelBlcok) {
        self.cancelBlcok(self);
        [UIView animateWithDuration:0.5 animations:^{
            [self removeFromSuperview];
        }];
    }
}

- (void)onClickOther:(UIButton *)button {
    if (self.otherBlock) {
        self.otherBlock(self);
        [UIView animateWithDuration:0.5 animations:^{
            [self removeFromSuperview];
        }];
    }
}

@end
