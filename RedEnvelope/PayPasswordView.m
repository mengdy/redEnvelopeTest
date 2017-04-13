//
//  PayPasswordView.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "PayPasswordView.h"
#import "HeadPayView.h"
@implementation PayPasswordView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame keyHeigh:(CGFloat)keyHeight {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self layerPayBgView:keyHeight];
        
        if (_payTextField == nil) {
            self.payTextField = [UITextField new];
            self.payTextField.delegate = self;
            self.payTextField.keyboardType = UIKeyboardTypeNumberPad;
            [_payTextField addTarget:self action:@selector(payPassWordChange:) forControlEvents:UIControlEventEditingChanged];
            _payTextField.delegate = self;
            [self addSubview:_payTextField];
        }
        [self.payTextField becomeFirstResponder];
        
    }
    
    return self;
}



-(void)layerPayBgView:(CGFloat )keyHeight{
    
    UIImage *passWordImage = [UIImage imageNamed:@"pwdInputBg"];
    CGFloat bgViewHeight = keyHeight + passWordImage.size.height + (54+30+50+15)*kScreen_H_Scale;
    
    if (_bgView == nil) {
        
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-bgViewHeight, kScreenWidth, bgViewHeight)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        HeadPayView *pay = [[HeadPayView alloc]initWithPayHeadFrame:CGRectMake(0, 0, kScreenWidth, 55*kScreen_H_Scale) title:@"请输入支付密码"];
        [pay cancelView:^{
            
            [_payTextField resignFirstResponder];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelPay" object:nil];
        }];
        [_bgView addSubview:pay];
        
        self.passWordView = [[UIImageView alloc]initWithFrame:CGRectMake(22*kScreen_W_Scale, CGRectGetMaxY(pay.frame)+30*kScreen_H_Scale,kScreenWidth-44*kScreen_W_Scale,passWordImage.size.height)];
        _passWordView.image = passWordImage;
        [_bgView  addSubview:_passWordView];
        
        self.forgetPwBtn = [[UIButton alloc]initWithFrame:CGRectMake(22*kScreen_W_Scale, CGRectGetMaxY(_passWordView.frame)+15*kScreen_H_Scale, CGRectGetWidth(_passWordView.frame), 30*kScreen_H_Scale)];
        [_forgetPwBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPwBtn setTitleColor:[UIColor colorWithHexString:@"4eb4ee"] forState:UIControlStateNormal];
        [_forgetPwBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        _forgetPwBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_forgetPwBtn addTarget:self action:@selector(forgetPassWordBrn:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_forgetPwBtn];
    }
    
}

#pragma mark --- 支付密码
-(void)payPassWordChange:(UITextField *)aTextField{
    
    if (_pointsArr == nil) {
        _pointsArr = [NSMutableArray arrayWithCapacity:1];
    }
    NSInteger index = (aTextField.text.length-1);
    
    if (index>=0 && index >= _pointsArr.count) {
        
        UIImage *pointImage = [UIImage imageNamed:@"point"];
        CGFloat gridWidth = (kScreenWidth - 44*kScreen_W_Scale)/6.f;
        CGFloat x = (gridWidth - pointImage.size.width)/2.f;
        CGFloat height = (CGRectGetHeight(_passWordView.frame) - pointImage.size.height)/2.f;
        NSLog(@"长度 : %ld",(long)index);
        UIImageView *pointImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x+index*gridWidth, height, pointImage.size.width, pointImage.size.height)];
        pointImageView.image = pointImage;
        [_passWordView addSubview:pointImageView];
        [_pointsArr addObject:pointImageView];
    }
    
    if (aTextField.text.length == 6) {
        
        NSLog(@"password finish %@",aTextField.text);
        [_payTextField resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelPay" object:nil];
        [_delegate putInPaswordFinish];
    }
    
}

#pragma mark  ---- 忘记密码
-(void)forgetPassWordBrn:(UIButton *)sender {
    
    NSLog(@"forget password done");
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"输入的文字 : %@,%@",string,textField.text);
    
    if ([string isEqualToString:@""]) {
        
        if (_pointsArr.count>0) {
            UIImageView *imageView = (UIImageView *)[_pointsArr lastObject];
            [imageView removeFromSuperview];
            [_pointsArr removeObjectAtIndex:(_pointsArr.count - 1)];
            NSLog(@"%@,%lu",_pointsArr,(unsigned long)[_pointsArr count]);
        }
    }
    
    return YES;
}




@end
