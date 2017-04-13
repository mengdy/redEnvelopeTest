//
//  UITextField+EXStyle.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/10.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "UITextField+EXStyle.h"

@implementation UITextField (EXStyle)

-(void)makeTextFieldPlaceholer{

    [self setValue:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

}

@end
