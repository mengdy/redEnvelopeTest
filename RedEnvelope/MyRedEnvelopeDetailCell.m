//
//  MyRedEnvelopeDetailCell.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MyRedEnvelopeDetailCell.h"
#import "UIColor+Expanded.h"
#import "NSString+Size.h"

@implementation MyRedEnvelopeDetailCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        if (_mred_titleLabel == nil) {
            CGSize size = [NSString sizeWithText:@"普通红包" font:15.f textColor:@"333333"];
            self.mred_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, 15*kScreen_H_Scale, 250*kScreen_W_Scale, size.height)];
            _mred_titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
            _mred_titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
            [self addSubview:_mred_titleLabel];
        }
        
        if (_mred_timeLabel == nil) {
            CGSize size = [NSString sizeWithText:@"2017-04-23" font:12.f textColor:@"999999"];

            self.mred_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, CGRectGetMaxY(_mred_titleLabel.frame)+5*kScreen_H_Scale, 250*kScreen_W_Scale, size.height)];
            _mred_timeLabel.font = [UIFont systemFontOfSize:12.f];
            _mred_timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
            [self addSubview:_mred_timeLabel];
        }
        
        if (_mred_balanceLabel == nil) {
            CGSize size = [NSString sizeWithText:@"2.00元" font:15.f textColor:@"ee4e4e"];
            self.mred_balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-120*kScreen_W_Scale, 15*kScreen_H_Scale, 105*kScreen_W_Scale, size.height)];
            _mred_balanceLabel.font = [UIFont systemFontOfSize:15.f];
            _mred_balanceLabel.textColor = [UIColor colorWithHexString:@"ee4e4e"];
            _mred_balanceLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_mred_balanceLabel];
        }
        
        if (_mred_statelLabel == nil) {
            CGSize size = [NSString sizeWithText:@"已领取2/2" font:12.f textColor:@"999999"];

            self.mred_statelLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-120*kScreen_W_Scale, CGRectGetMinY(_mred_timeLabel.frame), 105*kScreen_W_Scale, size.height)];
            _mred_statelLabel.textColor = [UIColor colorWithHexString:@"999999"];
            _mred_statelLabel.font = [UIFont systemFontOfSize:12.f];
            _mred_statelLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_mred_statelLabel];
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


}

@end
