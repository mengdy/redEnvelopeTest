//
//  MYReceivedEnevlopeView.h
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYReceivedEnevlopeView : UIView

@property (nonatomic,strong)UIImageView  *myImageView;
@property (nonatomic,strong)UIImage      *myImage;
@property (nonatomic,strong)UILabel      *markLabel;
@property (nonatomic,strong)NSString     *markStr;
@property (nonatomic,strong)UILabel      *reRedBalanceLabel;
@property (nonatomic,strong)NSString     *reRedBalance;
@property (nonatomic,strong)UILabel      *reRedCountLabel;
@property (nonatomic,strong)NSString     *reRedCount;
@property (nonatomic,strong)NSString     *bestLuckStr;
@property (nonatomic,strong)UILabel      *bestLuckLabel;


-(instancetype)initWithReciRedEnvelopeFrame:(CGRect)frame myImage:(UIImage *)myImage markStr:(NSString *)markStr redBalance:(NSString *)redBalance redCount:(NSString *)redCount bestLuckStr:(NSString *)bestLuckStr;


@end
