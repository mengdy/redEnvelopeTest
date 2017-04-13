//
//  UILabel+AddPic.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/12.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "UILabel+AddPic.h"

@implementation UILabel (AddPic)


+(NSMutableAttributedString *)addPicInLabelRight:(NSString *)imageStr textTitle:(NSString *)title{


    UIImage *puImage = [UIImage imageNamed:imageStr];
    NSTextAttachment *attch = [[NSTextAttachment alloc]init];
    attch.image = puImage;
    attch.bounds = CGRectMake(0, -2,puImage.size.width, puImage.size.height);
    //创建带图片的富文本
    NSMutableAttributedString *attributStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSAttributedString *atStr = [NSAttributedString attributedStringWithAttachment:attch];
    [attributStr insertAttributedString:atStr atIndex:title.length];
    
    return attributStr;
}


@end
