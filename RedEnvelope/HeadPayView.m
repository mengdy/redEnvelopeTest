//
//  HeadPayView.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "HeadPayView.h"
#import "UIColor+Expanded.h"



@implementation HeadPayView


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
    }

    return self;
}

-(instancetype)initWithPayHeadFrame:(CGRect)frame title:(NSString *)title{

    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *topView = [[UIView alloc]initWithFrame:frame];
        topView.backgroundColor = [UIColor clearColor];
        [self addSubview:topView];
        
        UIImage *cancelImage = [UIImage imageNamed:@"delete"];
        self.payHeadBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale,(54*kScreen_H_Scale - cancelImage.size.height)/2.f, cancelImage.size.width, cancelImage.size.height)];
        [_payHeadBtn setImage:cancelImage forState:UIControlStateNormal];
        [_payHeadBtn addTarget:self action:@selector(delegetPayView:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:_payHeadBtn];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_W_Scale*15+cancelImage.size.width,5*kScreen_H_Scale, kScreenWidth-(15*kScreen_W_Scale+cancelImage.size.width)*2, 44*kScreen_H_Scale)];
        topLabel.text = title;
        topLabel.font = [UIFont systemFontOfSize:16.f];
        topLabel.textAlignment = NSTextAlignmentCenter;
        topLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [topView addSubview:topLabel];
        
        UIView *lineVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 54*kScreen_H_Scale, kScreenWidth, 0.5*kScreen_H_Scale)];
        lineVeiw.backgroundColor = [UIColor colorWithHexString:@"e1e1e1"];
        [topView addSubview:lineVeiw];

        
    }

    return self;
}

-(void)delegetPayView:(UIButton *)cancel{

    if (_block) {
        
        _block();
    }

}

-(void)cancelView:(delegetPayBlock)bolock{

    self.block = bolock;

}

@end
