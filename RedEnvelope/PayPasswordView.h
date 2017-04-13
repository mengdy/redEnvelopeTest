//
//  PayPasswordView.h
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Expanded.h"

@protocol finishPasswordPayDelegate <NSObject>

-(void)putInPaswordFinish;

@end


@interface PayPasswordView : UIView<UITextFieldDelegate>

@property (nonatomic,strong)UIView          *bgView;
@property (nonatomic,strong)UITextField     *payTextField;
@property (nonatomic,strong)UIButton        *cancelBtn;
@property (nonatomic,strong)UIButton        *forgetPwBtn;
@property (nonatomic,strong)UIImageView     *passWordView;
@property (nonatomic,strong)NSMutableArray  *pointsArr;
@property (nonatomic,weak)id<finishPasswordPayDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame keyHeigh:(CGFloat)keyHeight;


@end
