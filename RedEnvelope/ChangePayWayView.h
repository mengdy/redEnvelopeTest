//
//  ChangePayWayView.h
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changePayWayDelegate <NSObject>

-(void)changePayWayTitle:(NSString *)title index:(NSInteger)index;

@end


@interface ChangePayWayView : UIView

@property (nonatomic,assign)NSInteger rows;
@property (nonatomic,weak)id <changePayWayDelegate>delegate;
@property (nonatomic,assign)NSInteger changeIndex;


-(instancetype)initWithChangePayWayFrame:(CGRect)frame;

@end
