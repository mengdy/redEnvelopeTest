//
//  OpenRedEnveView.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/13.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "OpenRedEnveView.h"
#import "UIColor+Expanded.h"
#import "NSString+Size.h"

@interface OpenRedEnveView()

@property (strong, nonatomic)UIImageView *enveBgImageView;
@property (strong, nonatomic)UIButton    *splitBtn;
@property (strong, nonatomic)UIImageView *headImageView;
@property (strong, nonatomic)UILabel     *nameLabel;
@property (strong, nonatomic)UILabel     *redTypeLabel;
@property (strong, nonatomic)UILabel     *sentimentLabel;

@property (strong, nonatomic)UIButton    *openDetailBtn;
@property (strong, nonatomic)UIButton    *shutGetRedBtn;

@end



@implementation OpenRedEnveView




-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithOpenRedEnvelopeFrame:(CGRect)frame{

    self= [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        
        if (_enveBgImageView == nil) {
            
            self.enveBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300*kScreen_W_Scale, 420*kScreen_H_Scale)];
            _enveBgImageView.image = [UIImage imageNamed:@"packet03"];
            _enveBgImageView.center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
            _enveBgImageView.userInteractionEnabled = YES;
            [self addSubview:_enveBgImageView];
        }
        
        if (_splitBtn == nil) {
            
            self.splitBtn = [[UIButton alloc]initWithFrame:CGRectMake((300-100)*kScreen_W_Scale/2.f, 80*kScreen_H_Scale, 100*kScreen_W_Scale, 100*kScreen_W_Scale)];
            [_splitBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"f8bf5a"]] forState:UIControlStateNormal];
            [_splitBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"cccccc"]] forState:UIControlStateDisabled];
            _splitBtn.layer.borderWidth = 4.f;
            _splitBtn.layer.borderColor = [UIColor colorWithHexString:@"f0a420"].CGColor;
            _splitBtn.layer.cornerRadius = 50*kScreen_W_Scale;
            _splitBtn.layer.masksToBounds = YES;
            
            [_splitBtn setTitle:@"拆" forState:UIControlStateNormal];
            _splitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:38.f] ;
            [_splitBtn setTitleColor:[UIColor colorWithHexString:@"c58008"] forState:UIControlStateNormal];
            [_splitBtn addTarget:self action:@selector(openRedClick:) forControlEvents:UIControlEventTouchUpInside];
            [_enveBgImageView addSubview:_splitBtn];
        }
        
        if (_headImageView == nil) {
            
            self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake((300-50)*kScreen_W_Scale/2.f,110*kScreen_H_Scale+100*kScreen_W_Scale, 50*kScreen_W_Scale, 50*kScreen_W_Scale)];
            _headImageView.image = [UIImage imageNamed:@"headPic"];
            _headImageView.layer.cornerRadius = 25*kScreen_W_Scale;
            _headImageView.layer.masksToBounds = YES;
            [_enveBgImageView addSubview:_headImageView];
            
        }
        
        if (_nameLabel == nil) {
            CGSize size = [NSString sizeWithText:@"李琦" font:15.f textColor:@"fcc972"];
            self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 120*kScreen_H_Scale+150*kScreen_W_Scale, 300*kScreen_W_Scale, size.height)];
            _nameLabel.text = @"李雨琦";
            _nameLabel.textColor = [UIColor colorWithHexString:@"fcc972"];
            _nameLabel.font = [UIFont boldSystemFontOfSize:15.f];
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            [_enveBgImageView addSubview:_nameLabel];
        }
        
        if (_redTypeLabel == nil) {
            CGSize size = [NSString sizeWithText:@"发个红包" font:12.f textColor:@"fcc972"];
            self.redTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.nameLabel.frame.origin.y+self.nameLabel.frame.size.height+10*kScreen_H_Scale, 300*kScreen_W_Scale, size.height)];
            _redTypeLabel.text = @"发了个红包，金额随机";
            _redTypeLabel.textColor = [UIColor colorWithHexString:@"fcc972"];
            _redTypeLabel.font = [UIFont boldSystemFontOfSize:12.f];
            _redTypeLabel.textAlignment = NSTextAlignmentCenter;
            [_enveBgImageView addSubview:_redTypeLabel];
        }
        
        if (_sentimentLabel == nil) {
            CGSize size = [NSString sizeWithText:@"发个红包" font:18.f textColor:@"fcc972"];
            self.sentimentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.redTypeLabel.frame.origin.y+self.redTypeLabel.frame.size.height+20*kScreen_H_Scale, 300*kScreen_W_Scale, size.height)];
            _sentimentLabel.text = @"恭喜发财，大吉大利";
            _sentimentLabel.textColor = [UIColor colorWithHexString:@"fcc972"];
            _sentimentLabel.font = [UIFont boldSystemFontOfSize:18.f];
            _sentimentLabel.textAlignment = NSTextAlignmentCenter;
            [_enveBgImageView addSubview:_sentimentLabel];
            
        }
        
        if (_openDetailBtn == nil) {
            
            self.openDetailBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 420*kScreen_H_Scale-48*kScreen_H_Scale, 300*kScreen_W_Scale, 30*kScreen_H_Scale)];
            [_openDetailBtn setTitle:@"查看领取详情>" forState:UIControlStateNormal];
            [_openDetailBtn setTitleColor:[UIColor colorWithHexString:@"fcc972"] forState:UIControlStateNormal];
            _openDetailBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
            [_openDetailBtn addTarget:self action:@selector(checkGetRedEnveDetailClick:) forControlEvents:UIControlEventTouchUpInside];
            [_enveBgImageView addSubview:_openDetailBtn];
        }
        
        if (_shutGetRedBtn == nil) {
            
            self.shutGetRedBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*kScreen_W_Scale, 5*kScreen_H_Scale, 30*kScreen_W_Scale, 30*kScreen_W_Scale)];
            [_shutGetRedBtn setTitle:@"" forState:UIControlStateNormal];
            [_shutGetRedBtn addTarget:self action:@selector(shutGetRedEnvelopeViewClick:) forControlEvents:UIControlEventTouchUpInside];
            [_enveBgImageView addSubview:_shutGetRedBtn];
        }
        
        
    }

    return self;

}

-(void)openRedClick: (UIButton *)openBtn{

    [_delegate openRedEnvelope];

}


//
-(void)checkGetRedEnveDetailClick:(UIButton *)chectBtn{

    [_delegate checkGetRedEnvelopeAmountStatus];

}

-(void)shutGetRedEnvelopeViewClick:(UIButton *)shutBtn{

    [_delegate deleteGetRedEnvelopeView];

}



//背景颜色转变成图片
- (UIImage *)imageWithColor:(UIColor *)color {
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
