//
//  ChangePayWayCell.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "ChangePayWayCell.h"
#import "UIColor+Expanded.h"
@implementation ChangePayWayCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        if (_pw_logoImageView == nil) {
            
            self.pw_logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15*kScreen_H_Scale, 15*kScreen_H_Scale, 30*kScreen_W_Scale, 30*kScreen_W_Scale)];
            _pw_logoImageView.backgroundColor = [UIColor clearColor];
            [self addSubview:_pw_logoImageView];
        }
        
        if (_pw_titleLabel == nil) {
            
            self.pw_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_pw_logoImageView.frame)+10*kScreen_W_Scale, 15*kScreen_H_Scale,kScreenWidth - CGRectGetMaxX(_pw_logoImageView.frame) - 55*kScreen_W_Scale, 30*kScreen_H_Scale)];
            _pw_titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
            _pw_titleLabel.font = [UIFont systemFontOfSize:15.f];
            [self addSubview:_pw_titleLabel];
        }
        
        if (_pw_balanceLabel == nil) {
            
            self.pw_balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_pw_titleLabel.frame), CGRectGetMaxY(_pw_titleLabel.frame)+10*kScreen_H_Scale, CGRectGetWidth(_pw_titleLabel.frame), 20*kScreen_H_Scale)];
            _pw_balanceLabel.font = [UIFont systemFontOfSize:12.f];
            _pw_balanceLabel.textColor = [UIColor colorWithHexString:@"999999"];
            [self addSubview:_pw_balanceLabel];
        }
        
        if (_pw_selectBtn == nil) {
            
            self.pw_selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 45*kScreen_W_Scale, 30*kScreen_H_Scale, 40*kScreen_W_Scale, 40*kScreen_H_Scale)];
            [_pw_selectBtn setImage:[UIImage imageNamed:@"no_choose"] forState:UIControlStateNormal];
            [self addSubview:_pw_selectBtn];
        
        }
        
    }

    return self;
}













- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
