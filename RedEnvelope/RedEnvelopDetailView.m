//
//  RedEnvelopDetailView.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "RedEnvelopDetailView.h"
#import "MyRedEnvelopeDetailCell.h"
#import "UIColor+Expanded.h"
@implementation RedEnvelopDetailView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

-(instancetype)initWithRedEnvelopeDetailFrame:(CGRect)frame dataSours:(NSMutableArray *)datas row:(NSInteger)row{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.dataSource = datas;
        self.rows = row;
        [self makeRedDetailTabelViewFram:frame];
        
    }
    
    return self;
}

-(void)makeRedDetailTabelViewFram:(CGRect)frame{

    if (_redTableView == nil) {
        
        self.redTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _redTableView.delegate = self;
        _redTableView.dataSource = self;
        [self addSubview:_redTableView];
        
    }
}

#pragma mark --- 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *str = @"celll";
    MyRedEnvelopeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[MyRedEnvelopeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    
    cell.mred_titleLabel.text = @"拼手气红包";
    cell.mred_timeLabel.text  = @"2017-03-22 16:14:51";
    cell.mred_balanceLabel.text = @"2.00元";
    [self modifyLabelSomeText:cell.mred_balanceLabel string:@"2.00元" changeStr:@"元"];
    cell.mred_statelLabel.text = @"已领完2/2";
    
    return cell;
}

-(void)modifyLabelSomeText:(UILabel *)label string:(NSString *)str changeStr:(NSString *)changeStr{
    
    NSMutableAttributedString *hintString2=[[NSMutableAttributedString alloc]initWithString:str];
    NSRange range1=[[hintString2 string]rangeOfString:changeStr];
    [hintString2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"],NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:range1];
    label.attributedText = hintString2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 68*kScreen_H_Scale;
}




@end
