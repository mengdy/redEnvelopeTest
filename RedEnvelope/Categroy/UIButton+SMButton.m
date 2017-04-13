//
//  UIButton+SMButton.m
//  SM_Sumpay
//
//  Created by mengdy on 17/2/16.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "UIButton+SMButton.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIButton (SMButton)

+(instancetype)buttonWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andTitle:(NSString*)title andTitleColor:(UIColor *)titleColor andBorderColor:(UIColor*)borderColor andCornerRadius:(CGFloat)cornerRadius;
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:backgroundColor];
    
//    [btn setTitle:title forState:UIControlStateDisabled];
//    [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"cccccc"]] forState:UIControlStateDisabled];
//    [btn setBackgroundImage:[self imageWithColor:backgroundColor] forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, frame.size.height)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = btn.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    btn.layer.mask = maskLayer;

    [btn setEnabled:NO];
    if (borderColor) {
        btn.layer.borderColor = borderColor.CGColor;
        btn.layer.borderWidth = 1;
    }
    return btn;
}


+(instancetype)backButtonWithFrame:(CGRect)frame{

    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8.f, 0, 8)];
    
    return button;
}


+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}



@end
