//
//  MySendEnvelopView.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MySendEnvelopView.h"
#import "UIColor+Expanded.h"
#import "NSString+Size.h"

@implementation MySendEnvelopView


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(instancetype)initWithSendRedEnvelopeFrame:(CGRect)frame myImage:(UIImage *)myImage markStr:(NSString *)markStr redBalance:(NSString *)redBalance redCount:(NSString *)redCount{

    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.myImage = myImage;
        self.markStr = markStr;
        self.sendRedBalance = redBalance;
        self.sendRedCount = redCount;
        [self designMYSendRedEnvelopeView];
    }

    return self;
}

-(void)designMYSendRedEnvelopeView{

    if (_myImageView == nil) {
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 90*kScreen_W_Scale)/2.f, 55*kScreen_H_Scale, 90*kScreen_W_Scale, 90*kScreen_W_Scale)];
        _myImageView.image = self.myImage;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_myImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(45*kScreen_W_Scale, 45*kScreen_W_Scale)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = _myImageView.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        _myImageView.layer.mask = maskLayer;
        
        [self addSubview:_myImageView];
    }

    if (_markLabel == nil) {
        CGSize size = [NSString sizeWithText:@"张小白" font:16.f textColor:@"333333"];
        self.markLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_myImageView.frame)+15*kScreen_H_Scale, kScreenWidth,size.height)];
        _markLabel.text = _markStr;
        _markLabel.font = [UIFont systemFontOfSize:16.f];
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self modifyLabelSomeText:_markLabel string:_markStr changeStr:@"共发出"];
        [self addSubview:_markLabel];
        
    }

    if (_sendRedBalanceLabel == nil) {
        CGSize size = [NSString sizeWithText:@"5.00元" font:24.f textColor:@"ee4e4e"];
        self.sendRedBalanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_markLabel.frame)+20*kScreen_H_Scale, kScreenWidth, size.height)];
        _sendRedBalanceLabel.text = _sendRedBalance;
        _sendRedBalanceLabel.textAlignment = NSTextAlignmentCenter;
        _sendRedBalanceLabel.textColor = [UIColor colorWithHexString:@"ee4e4e"];
        _sendRedBalanceLabel.font = [UIFont systemFontOfSize:24.f];
        [self modifyLabelSomeText:_sendRedBalanceLabel string:_sendRedBalance changeStr:@"元"];
        [self addSubview:_sendRedBalanceLabel];
    }
    
    if (_sendRedCountLabel == nil) {
        CGSize size = [NSString sizeWithText:@"发出红包" font:14.f textColor:@"999999"];
        self.sendRedCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_sendRedBalanceLabel.frame)+20*kScreen_H_Scale, kScreenWidth, size.height)];
        NSString *str = [NSString stringWithFormat:@"发出红包 %@ 个",_sendRedCount];
        _sendRedCountLabel.text = str;
        _sendRedCountLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _sendRedCountLabel.font = [UIFont systemFontOfSize:14.f];
        _sendRedCountLabel.textAlignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *hintString2=[[NSMutableAttributedString alloc]initWithString:str];
        NSRange range1=[[hintString2 string]rangeOfString:_sendRedCount];
        [hintString2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ee4e4e"],NSFontAttributeName:[UIFont systemFontOfSize:18.f]} range:range1];
        _sendRedCountLabel.attributedText = hintString2;
        [self addSubview:_sendRedCountLabel];
    
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_sendRedCountLabel.frame)+30*kScreen_H_Scale, kScreenWidth, 1*kScreen_H_Scale)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"e1e1e1"];
    [self addSubview:lineView];

    
}






-(void)modifyLabelSomeText:(UILabel *)label string:(NSString *)str changeStr:(NSString *)changeStr{
    
    NSMutableAttributedString *hintString2=[[NSMutableAttributedString alloc]initWithString:str];
    NSRange range1=[[hintString2 string]rangeOfString:changeStr];
    [hintString2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:range1];
    label.attributedText = hintString2;
    
}




@end
