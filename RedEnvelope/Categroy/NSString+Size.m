//
//  NSString+Size.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/12.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "NSString+Size.h"
#import "UIColor+Expanded.h"


@implementation NSString (Size)


#pragma  mark -- 获取文本的宽高
+(CGSize)sizeWithText:(NSString *)text font:(CGFloat)fontFloat textColor:(NSString *)color{
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:color],NSFontAttributeName:[UIFont systemFontOfSize:fontFloat]};
    CGSize size = [text  sizeWithAttributes:dic];
    
    return size;
}



@end
