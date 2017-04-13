//
//  UIButton+SMButton.h
//  SM_Sumpay
//
//  Created by mengdy on 17/2/16.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SMButton)

+(instancetype)buttonWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)backgroundColor andTitle:(NSString*)title andTitleColor:(UIColor *)titleColor andBorderColor:(UIColor*)borderColor andCornerRadius:(CGFloat)cornerRadius;

+(instancetype)backButtonWithFrame:(CGRect)frame;



@end
