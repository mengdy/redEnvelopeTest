//
//  RedEnvelopDetailView.h
//  RedEnvelope
//
//  Created by mengdy on 17/4/11.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedEnvelopDetailView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger       rows;
@property (nonatomic,strong)UITableView    *redTableView;
-(instancetype)initWithRedEnvelopeDetailFrame:(CGRect)frame dataSours:(NSMutableArray *)datas row:(NSInteger)row;


@end
