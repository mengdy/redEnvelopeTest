//
//  OpenRedEnveController.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/13.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "OpenRedEnveController.h"
#import "OpenRedEnveView.h"
#import "UIViewController+Navigat.h"
#import "SendEnvelopeGroController.h"
#import "SendEnevelopePerController.h"
#import "MySendEnvelopView.h"
#import "MyRedEnevelopeController.h"
#import "MYRedEnveGetDetailController.h"
@interface OpenRedEnveController ()<getRedEnvelopeDelegate>

@property (strong, nonatomic)OpenRedEnveView *openView;

@end

@implementation OpenRedEnveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigation_StyleTitle:@"拆红包"];
    self.navigationItem.leftBarButtonItem = [self left_BarButtonItem];
    UIButton *openBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 80*kScreen_H_Scale, kScreenWidth, 40*kScreen_H_Scale)];
    [openBtn setTitle:@"拆" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [openBtn setBackgroundColor:[UIColor yellowColor]];
    [openBtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];

    openBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 160*kScreen_H_Scale, kScreenWidth, 40*kScreen_H_Scale)];
    [openBtn setTitle:@"发个人红包" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [openBtn setBackgroundColor:[UIColor yellowColor]];
    [openBtn addTarget:self action:@selector(sendPeopeRedEnvelopeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];

    openBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 240*kScreen_H_Scale, kScreenWidth, 40*kScreen_H_Scale)];
    [openBtn setTitle:@"发群红包" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [openBtn setBackgroundColor:[UIColor yellowColor]];
    [openBtn addTarget:self action:@selector(sendGroupRedEnvelopeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];
    
    openBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 320*kScreen_H_Scale, kScreenWidth, 40*kScreen_H_Scale)];
    [openBtn setTitle:@"我的红包" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [openBtn setBackgroundColor:[UIColor yellowColor]];
    [openBtn addTarget:self action:@selector(myRedEnvelopeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];

    
}

-(void)openClick : (UIButton *)open{

    self.openView = [[OpenRedEnveView alloc]initWithOpenRedEnvelopeFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _openView.delegate = self;
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:_openView];

}
#pragma 关闭拆红包的页面
-(void)deleteGetRedEnvelopeView{

 [UIView animateWithDuration:1 animations:^{
     
     self.openView.alpha = 0;
 } completion:^(BOOL finished) {
     
     [self.openView removeFromSuperview];
     self.openView = nil;
 }];
    
}

//拆红包
-(void)openRedEnvelope{
    NSLog(@"拆红包");
}
//查看红包领取详情
-(void)checkGetRedEnvelopeAmountStatus{

    NSLog(@"查看红包领取详情");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendPeopeRedEnvelopeClick{

    [self.navigationController pushViewController:[[SendEnevelopePerController alloc] init] animated:YES];

}
-(void)sendGroupRedEnvelopeClick{
    
    [self.navigationController pushViewController:[[SendEnvelopeGroController alloc] init] animated:YES];
}

-(void)myRedEnvelopeClick{

    [self.navigationController pushViewController:[[MYRedEnveGetDetailController alloc] init] animated:YES];
}


@end
