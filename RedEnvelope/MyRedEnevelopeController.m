//
//  MyRedEnevelopeController.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MyRedEnevelopeController.h"
#import "UIViewController+Navigat.h"
#import "UIColor+Expanded.h"
#import "MySendEnvelopView.h"
#import "RedEnvelopDetailView.h"
#import "MYReceivedEnevlopeView.h"

@interface MyRedEnevelopeController ()

@property (nonatomic,strong)MySendEnvelopView    *mySendView;
@property (nonatomic,strong)RedEnvelopDetailView *detailView;

@property (nonatomic,strong)MYReceivedEnevlopeView *myReView;


@end

@implementation MyRedEnevelopeController

-(void)viewDidAppear:(BOOL)animated{

   [super viewDidAppear:animated];
    
   [self firstStartLoadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    [self setNavigation_StyleTitle:@"我的红包"];
   self.navigationItem.leftBarButtonItem = [self left_BarButtonItem];
   
    if (_receivedBtn == nil) {
        
        self.receivedBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2.f, 45*kScreen_H_Scale)];
        [_receivedBtn setTitle:@"收到的红包" forState:UIControlStateNormal];
        [_receivedBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [_receivedBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_receivedBtn setBackgroundColor:[UIColor whiteColor]];
        [_receivedBtn addTarget:self action:@selector(receivedRedEnvelopeEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_receivedBtn];
    }
    if (_receiveLineView == nil) {
        
        self.receiveLineView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_receivedBtn.frame), kScreenWidth/2.f, 1*kScreen_H_Scale)];
        _receiveLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        [self.view addSubview:_receiveLineView];
    }
    
   
    if (_sendBtn == nil) {
        
        self.sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2.f, 0, kScreenWidth/2.f, 45*kScreen_H_Scale)];
        [_sendBtn setTitle:@"发出的红包" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor colorWithHexString:@"ee4e4e"] forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_sendBtn setBackgroundColor:[UIColor whiteColor]];
        [_sendBtn addTarget:self action:@selector(sendRedEnvelopeEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_sendBtn];
    }
    if (_sendLineView == nil) {
        
        self.sendLineView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2.f,CGRectGetMaxY(_receivedBtn.frame), kScreenWidth/2.f, 1*kScreen_H_Scale)];
        _sendLineView.backgroundColor = [UIColor colorWithHexString:@"ee4e4e"];
        [self.view addSubview:_sendLineView];
    }

}


#pragma mark --- 接受红包的事件
-(void)receivedRedEnvelopeEvent : (UIButton *)receBtn{

    [self changeBackGroundReTitleColor:@"ee4e4e" SeLineColor:@"e1e1e1" SeTitleColor:@"999999" RelineColor:@"ee4e4e"];
    
    self.mySendView.hidden = YES;
    self.myReView.hidden = NO;
    
    if (_myReView == nil) {
        
    self.myReView = [[MYReceivedEnevlopeView alloc]initWithReciRedEnvelopeFrame:CGRectMake(0, 46*kScreen_H_Scale, kScreenWidth, 318*kScreen_H_Scale) myImage:[UIImage imageNamed:@"headPic"] markStr:@"张小清共收到" redBalance:@"26.00元"  redCount:@"3" bestLuckStr:@"15.00"];
    
    [self.view addSubview:_myReView];
    }

}

#pragma mark --- 发送红包的事件
-(void)sendRedEnvelopeEvent:(UIButton *)sendBtn {

    [self changeBackGroundReTitleColor:@"999999" SeLineColor:@"ee4e4e" SeTitleColor:@"ee4e4e" RelineColor:@"e1e1e1"];
    
    self.mySendView.hidden = NO;
    self.myReView.hidden = YES;
    
    [self firstStartLoadView];
 }




-(void)changeBackGroundReTitleColor:(NSString *)reTitleColor SeLineColor:(NSString *)seLineColor SeTitleColor:(NSString *)seTitleColor RelineColor:(NSString *)reLineColor {

    [self.receivedBtn setTitleColor:[UIColor colorWithHexString:reTitleColor] forState:UIControlStateNormal];
    self.receiveLineView.backgroundColor = [UIColor colorWithHexString:reLineColor];
    
    [self.sendBtn setTitleColor:[UIColor colorWithHexString:seTitleColor] forState:UIControlStateNormal];
    [self.sendLineView setBackgroundColor:[UIColor colorWithHexString:seLineColor]];


}

#pragma  mark start load view
-(void)firstStartLoadView{

    if (_mySendView == nil) {
    self.mySendView = [[MySendEnvelopView alloc]initWithSendRedEnvelopeFrame:CGRectMake(0, 46*kScreen_H_Scale, kScreenWidth, 296*kScreen_H_Scale) myImage:[UIImage imageNamed:@"headPic"] markStr:@"张小清共发出" redBalance:@"26.00元" redCount:@"5"];
    [self.view addSubview:_mySendView];
        
    }
    
    
   if (_detailView == nil) {
    
    self.detailView = [[RedEnvelopDetailView alloc]initWithRedEnvelopeDetailFrame:CGRectMake(0, CGRectGetMaxY(_mySendView.frame), kScreenWidth,kScreenHeight - 64.f - 343*kScreen_H_Scale) dataSours:nil row:3];
    
    [self.view addSubview:_detailView];
   }

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
