//
//  MYReceivedEnevlopeView.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MYReceivedEnevlopeView.h"
#import "UIColor+Expanded.h"
#import "NSString+Size.h"
@implementation MYReceivedEnevlopeView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(instancetype)initWithReciRedEnvelopeFrame:(CGRect)frame myImage:(UIImage *)myImage markStr:(NSString *)markStr redBalance:(NSString *)redBalance redCount:(NSString *)redCount bestLuckStr:(NSString *)bestLuckStr{

    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.myImage = myImage;
        self.markStr = markStr;
        self.reRedBalance = redBalance;
        self.reRedCount = redCount;
        self.bestLuckStr = bestLuckStr;
        [self designMYReceivedRedEnvelopeView];
    }
    
    return self;


}

-(void)designMYReceivedRedEnvelopeView{


    if (_myImageView == nil) {
        
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 90*kScreen_W_Scale)/2.f, 45*kScreen_H_Scale, 90*kScreen_W_Scale, 90*kScreen_W_Scale)];
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
        self.markLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_myImageView.frame)+15*kScreen_H_Scale, kScreenWidth, size.height)];
        _markLabel.text = _markStr;
        _markLabel.font = [UIFont systemFontOfSize:18.f];
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self modifyLabelSomeText:_markLabel string:_markStr changeStr:@"共收到"];
        [self addSubview:_markLabel];
        
    }
    
    if (_reRedBalanceLabel == nil) {
        CGSize size = [NSString sizeWithText:@"5.00元" font:24.f textColor:@"ee4e4e"];
        self.reRedBalanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_markLabel.frame)+12*kScreen_H_Scale, kScreenWidth, size.height)];
        _reRedBalanceLabel.text = _reRedBalance;
        _reRedBalanceLabel.textAlignment = NSTextAlignmentCenter;
        _reRedBalanceLabel.textColor = [UIColor colorWithHexString:@"ee4e4e"];
        _reRedBalanceLabel.font = [UIFont systemFontOfSize:24.f];
        [self modifyLabelSomeText:_reRedBalanceLabel string:_reRedBalance changeStr:@"元"];
        [self addSubview:_reRedBalanceLabel];
    }
    
    if (_reRedCountLabel == nil) {
        
        CGSize size = [NSString sizeWithText:@"3" font:16.f textColor:@"ee4e4e"];
        self.reRedCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_reRedBalanceLabel.frame)+40*kScreen_H_Scale, kScreenWidth/2.f, size.height)];
        _reRedCountLabel.text = _reRedCount;
        _reRedCountLabel.textColor = [UIColor colorWithHexString:@"ee4e4e"];
        _reRedCountLabel.font = [UIFont systemFontOfSize:16.f];
        _reRedCountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_reRedCountLabel];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_reRedCountLabel.frame)+5*kScreen_H_Scale, kScreenWidth/2.f, size.height)];
        label.text = @"收到红包";
        label.textColor = [UIColor colorWithHexString:@"999999"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16.f];
        [self addSubview:label];
    }
    
    if (_bestLuckLabel == nil) {
        CGSize size = [NSString sizeWithText:@"15.00" font:16.f textColor:@"ee4e4e"];
        self.bestLuckLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2.f, CGRectGetMinY(_reRedCountLabel.frame), kScreenWidth/2.f, size.height)];
        _bestLuckLabel.text = _bestLuckStr;
        _bestLuckLabel.textColor = [UIColor colorWithHexString:@"ee4e4e"];
        _bestLuckLabel.textAlignment = NSTextAlignmentCenter;
        _bestLuckLabel.font = [UIFont systemFontOfSize:16.f];
        [self addSubview:_bestLuckLabel];
        
        UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2.f, CGRectGetMaxY(_reRedCountLabel.frame)+5*kScreen_H_Scale, kScreenWidth/2.f, size.height)];
        labe.text = @"手气最佳";
        labe.textAlignment = NSTextAlignmentCenter;
        labe.textColor = [UIColor colorWithHexString:@"999999"];
        labe.font = [UIFont systemFontOfSize:16.f];
        [self addSubview:labe];
        
    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_reRedCountLabel.frame)+_reRedCountLabel.frame.size.height+30*kScreen_H_Scale, kScreenWidth, 1*kScreen_H_Scale)];
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
