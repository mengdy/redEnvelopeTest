//
//  MYRedEnveGetDetailController.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/13.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MYRedEnveGetDetailController.h"
#import "UIViewController+Navigat.h"
#import "UIColor+Expanded.h"
#import "NSString+Size.h"

#import "RedEnvelopDetailView.h" //红包详情的tableView

#import "MyRedEnevelopeController.h"

@interface MYRedEnveGetDetailController ()

@property (strong, nonatomic)UIImageView *myHeadImageView;
@property (strong, nonatomic)UILabel     *myEnveLabel;
@property (strong, nonatomic)UILabel     *luckLabel;
@property (strong, nonatomic)UILabel     *getDetailLabel;

@property (strong, nonatomic)UIButton    *enveRecordBtn;

@property (strong, nonatomic)UIView *myHeadView;
@property (strong, nonatomic)UIView *detailView;
@end

@implementation MYRedEnveGetDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    [self setNavigation_StyleTitle:@"我的红包"];
    self.navigationItem.leftBarButtonItem = [self left_BarButtonItem];

    if (_myHeadView == nil) {
        
        self.myHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 252*kScreen_H_Scale)];
        _myHeadView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_myHeadView];
        
        if (_myHeadImageView == nil) {
            
            self.myHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 90*kScreen_W_Scale)/2.f, 55*kScreen_H_Scale, 90*kScreen_W_Scale, 90*kScreen_W_Scale)];
            _myHeadImageView.image = [UIImage imageNamed:@"headPic"];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_myHeadImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(45*kScreen_W_Scale, 45*kScreen_W_Scale)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            //设置大小
            maskLayer.frame = _myHeadImageView.bounds;
            //设置图形样子
            maskLayer.path = maskPath.CGPath;
            _myHeadImageView.layer.mask = maskLayer;
            
            [_myHeadView addSubview:_myHeadImageView];
        }
        
        if (_myEnveLabel == nil) {
            CGSize size = [NSString sizeWithText:@"张小白" font:16.f textColor:@"333333"];
            self.myEnveLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_myHeadImageView.frame)+15*kScreen_H_Scale, kScreenWidth,size.height)];
            _myEnveLabel.text = @"张小白的红包";
            _myEnveLabel.font = [UIFont systemFontOfSize:16.f];
            _myEnveLabel.textAlignment = NSTextAlignmentCenter;
            _myEnveLabel.textColor = [UIColor colorWithHexString:@"333333"];
            [self modifyLabelSomeText:_myEnveLabel string:@"张小白的红包" changeStr:@"的红包"];
            [_myHeadView addSubview:_myEnveLabel];
        }

        if (_luckLabel == nil) {
            CGSize size = [NSString sizeWithText:@"张小白" font:16.f textColor:@"999999"];
            self.luckLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_myEnveLabel.frame)+15*kScreen_H_Scale, kScreenWidth,size.height)];
            _luckLabel.text = @"恭喜发财,大吉大利";
            _luckLabel.font = [UIFont systemFontOfSize:16.f];
            _luckLabel.textAlignment = NSTextAlignmentCenter;
            _luckLabel.textColor = [UIColor colorWithHexString:@"999999"];
            [_myHeadView addSubview:_luckLabel];
        }
        
    }
    
    if (_getDetailLabel == nil) {
        CGSize size = [NSString sizeWithText:@"恭喜发财" font:24.f textColor:@"999999"];
        self.getDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, 252*kScreen_H_Scale, kScreenWidth, size.height)];
        _getDetailLabel.text = @"红包金额9.8元，等待对方领取";
        _getDetailLabel.font = [UIFont systemFontOfSize:15.f];
        _getDetailLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.view addSubview:_getDetailLabel];
    }
    
    if (_detailView == nil) {
        
        self.detailView = [[UIView alloc]initWithFrame:CGRectMake(0,282*kScreen_H_Scale, kScreenWidth, kScreenHeight - 282*kScreen_H_Scale)];
        _detailView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_detailView];
    }
    
    if (_enveRecordBtn == nil) {
        CGSize butSize = [NSString sizeWithText:@"查看我的红包" font:14.f textColor:@"999999"];
        NSLog(@"查看我的红包记录 : %f",butSize.height);
        self.enveRecordBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,kScreenHeight - 282*kScreen_H_Scale -130*kScreen_H_Scale, kScreenWidth, butSize.height)];
        [_enveRecordBtn setTitle:@"查看我的红包记录" forState:UIControlStateNormal];
        [_enveRecordBtn setTitleColor:[UIColor colorWithHexString:@"4eb4ee"] forState:UIControlStateNormal];
        _enveRecordBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_enveRecordBtn addTarget:self action:@selector(checkRedEnveRecordClick:) forControlEvents:UIControlEventTouchUpInside];
        [_detailView addSubview:_enveRecordBtn];
        
        NSLog(@"查看我的红包记录 : %f",_enveRecordBtn.frame.size.height);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_enveRecordBtn.frame)+10*kScreen_H_Scale, kScreenWidth, butSize.height)];
        label.text = @"未领取的红包，将于24小时后发起退款";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor colorWithHexString:@"999999"];
        label.textAlignment = NSTextAlignmentCenter;
        [_detailView addSubview:label];
        
    }
    
}


-(void)modifyLabelSomeText:(UILabel *)label string:(NSString *)str changeStr:(NSString *)changeStr{
    
    NSMutableAttributedString *hintString2=[[NSMutableAttributedString alloc]initWithString:str];
    NSRange range1=[[hintString2 string]rangeOfString:changeStr];
    [hintString2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:range1];
    label.attributedText = hintString2;
    
}

//查看红包记录
-(void)checkRedEnveRecordClick : (UIButton *)sender{

    [self.navigationController pushViewController:[[MyRedEnevelopeController alloc] init] animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
