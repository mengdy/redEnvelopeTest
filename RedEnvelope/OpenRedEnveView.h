//
//  OpenRedEnveView.h
//  RedEnvelope
//
//  Created by mengdy on 17/4/13.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getRedEnvelopeDelegate <NSObject>

//关闭页面
-(void)deleteGetRedEnvelopeView;

//拆红包
-(void)openRedEnvelope;

//查看红包分配情况
-(void)checkGetRedEnvelopeAmountStatus;

@end


@interface OpenRedEnveView : UIView

@property (weak,nonatomic)id<getRedEnvelopeDelegate>delegate;

-(instancetype)initWithOpenRedEnvelopeFrame:(CGRect)frame;


@end
