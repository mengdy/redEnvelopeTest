//
//  ChangePayWayView.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "ChangePayWayView.h"
#import "UIColor+Expanded.h"
#import "HeadPayView.h"
#import "ChangePayWayCell.h"


@interface ChangePayWayView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UIView *payWayBgView;
@property (nonatomic,strong)UITableView *payWayTabelView;
@property (nonatomic,strong)UIButton *delegetBtn;


@end


@implementation ChangePayWayView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}


-(instancetype)initWithChangePayWayFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        self.rows = 9;
        [self layerChangePayWayBgView];
        
    }
    return self;
}

-(void)layerChangePayWayBgView{

    if (_payWayBgView == nil) {
        
        self.payWayBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - (4*90 + 50*2)*kScreen_H_Scale, kScreenWidth, 6*90*kScreen_H_Scale)];
        self.payWayBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_payWayBgView];
      
        HeadPayView *pay = [[HeadPayView alloc]initWithPayHeadFrame:CGRectMake(0, 0, kScreenWidth, 55*kScreen_H_Scale) title:@"选择支付方式"];
        pay.backgroundColor = [UIColor clearColor];
        [pay cancelView:^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelChangePayWayView" object:nil];
        }];
        [_payWayBgView addSubview:pay];
       
        self.payWayTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pay.frame), kScreenWidth, 4*90*kScreen_H_Scale) style:UITableViewStylePlain];
        _payWayTabelView.delegate = self;
        _payWayTabelView.dataSource = self;
        _payWayTabelView.backgroundColor = [UIColor whiteColor];
        
        //使分割线距离左右两边个15
        _payWayTabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _payWayTabelView.separatorInset = UIEdgeInsetsMake(0, 15*kScreen_W_Scale, 0, 15*kScreen_W_Scale);
        [_payWayBgView addSubview:_payWayTabelView];
        
        
    }

}

#pragma mark --- UITabelView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rows;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idCell =[NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    ChangePayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
    if (!cell) {
        
        cell = [[ChangePayWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCell];
    }
    if (indexPath.row == self.changeIndex) {
        
        [cell.pw_selectBtn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    }
    
    if (indexPath.row == 0) {
        
        cell.pw_logoImageView.image = [UIImage imageNamed:@"change"];
        cell.pw_titleLabel.text = @"零钱";
        cell.pw_balanceLabel.text = @"30.25元";
    }
    if (indexPath.row == 1) {
        cell.pw_logoImageView.frame = CGRectMake(15*kScreen_W_Scale, 30*kScreen_H_Scale, 30*kScreen_W_Scale, 30*kScreen_W_Scale);
        cell.pw_titleLabel.frame = CGRectMake(CGRectGetMaxX(cell.pw_logoImageView.frame)+10*kScreen_W_Scale, 30*kScreen_H_Scale, kScreenWidth - CGRectGetMaxX(cell.pw_logoImageView.frame) - 55*kScreen_W_Scale, 30*kScreen_H_Scale);
        cell.pw_logoImageView.image = [UIImage imageNamed:@"alipay"];
        cell.pw_titleLabel.text = @"支付宝";
        cell.pw_balanceLabel.hidden = YES;
    }
    if (indexPath.row == 2) {
        
        cell.pw_logoImageView.image = [UIImage imageNamed:@"ICBC"];
        cell.pw_titleLabel.text = @"中国工商银行储蓄卡(尾号7541)";
        cell.pw_balanceLabel.text = @"单笔支付限额1000，单日支付限额1万";
    }
    if (indexPath.row >= 3 && indexPath.row <= (_rows-2)) {
        
        cell.pw_logoImageView.image = [UIImage imageNamed:@"ICBC"];
        cell.pw_titleLabel.text = @"中国工商银行储蓄卡(尾号7541)";
        cell.pw_balanceLabel.text = @"单笔支付限额1000，单日支付限额1万";
    }

    if (indexPath.row == _rows-1) {
        
        cell.pw_logoImageView.frame = CGRectMake(15*kScreen_W_Scale, 30*kScreen_H_Scale, 30*kScreen_W_Scale, 30*kScreen_W_Scale);
        cell.pw_titleLabel.frame = CGRectMake(CGRectGetMaxX(cell.pw_logoImageView.frame)+10*kScreen_W_Scale, 30*kScreen_H_Scale, kScreenWidth - CGRectGetMaxX(cell.pw_logoImageView.frame) - 55*kScreen_W_Scale, 30*kScreen_H_Scale);
        cell.pw_logoImageView.hidden = YES;
        cell.pw_titleLabel.text = @"+添加银行卡";
        cell.pw_balanceLabel.hidden = YES;
        [cell.pw_selectBtn setImage:[UIImage imageNamed:@"forward_arrow"] forState:UIControlStateNormal];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90*kScreen_H_Scale;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row < _rows) {
    
     for (int i = 0; i < (_rows - 1); i++) {
        ChangePayWayCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

        if (i == indexPath.row) {
            [cell.pw_selectBtn setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
            [_delegate changePayWayTitle:cell.pw_titleLabel.text index:indexPath.row];
        }else{
            [cell.pw_selectBtn setImage:[UIImage imageNamed:@"no_choose"] forState:UIControlStateNormal];
        }
    }
 }
    
    if (indexPath.row == 0) {
        
        
    }
    if (indexPath.row == 1) {
        
        
    }
    if (indexPath.row == 2) {
        
        
    }
    
    if (indexPath.row == 3) {
        
        NSLog(@"跳转到添加银行卡");
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelChangePayWayView" object:nil];
    
}


/*
//解决cell分割线位置问题
-(void)viewDidLayoutSubviews
{
    if ([_payWayTabelView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_payWayTabelView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_payWayTabelView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_payWayTabelView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
*/


@end
