//
//  HeadPayView.h
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^delegetPayBlock)();

@interface HeadPayView : UIView

@property (nonatomic,strong)UIButton *payHeadBtn;
@property (nonatomic,copy)delegetPayBlock block;

-(instancetype)initWithPayHeadFrame:(CGRect)frame title:(NSString *)title;

-(void)cancelView:(delegetPayBlock)bolock;


@end
