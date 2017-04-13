//
//  MySendEnvelopView.h
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySendEnvelopView : UIView

@property (nonatomic,strong)UIImageView  *myImageView;
@property (nonatomic,strong)UIImage      *myImage;
@property (nonatomic,strong)UILabel      *markLabel;
@property (nonatomic,strong)NSString     *markStr;
@property (nonatomic,strong)UILabel      *sendRedBalanceLabel;
@property (nonatomic,strong)NSString     *sendRedBalance;
@property (nonatomic,strong)UILabel      *sendRedCountLabel;
@property (nonatomic,strong)NSString     *sendRedCount;
@property (nonatomic,strong)UITableView  *sendTabelView;




-(instancetype)initWithSendRedEnvelopeFrame:(CGRect)frame myImage:(UIImage *)myImage markStr:(NSString *)markStr redBalance:(NSString *)redBalance redCount:(NSString *)redCount;


@end
