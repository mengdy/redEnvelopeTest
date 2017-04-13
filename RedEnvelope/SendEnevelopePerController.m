//
//  SendEneuelopePerController.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/10.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "SendEnevelopePerController.h"
#import "UIViewController+Navigat.h"
#import "UIColor+Expanded.h"
#import "UITextField+EXStyle.h"
#import "UIButton+SMButton.h"
#import "PayPasswordView.h"
#import "ChangePayWayView.h"


@interface SendEnevelopePerController ()<UITextFieldDelegate,changePayWayDelegate>

@property (nonatomic,strong)UITextField *moneyTextField;
@property (nonatomic,strong)UITextField *blessTextField;
@property (nonatomic,strong)NSString *envelopeStr;
@property (nonatomic,strong)NSString *blessStr;
@property (nonatomic,strong)UILabel *sendMoneyLabel;
@property (nonatomic,strong)UIButton *sendBtn;
@property (nonatomic,strong)UILabel *payWayLabel;
@property (nonatomic,assign)CGFloat  keyHight;

@property (nonatomic,strong)PayPasswordView *payBgView;
@property (nonatomic,strong)ChangePayWayView *changePayWayBgView;

@property (nonatomic,assign)NSInteger changeIndex;


@end

@implementation SendEnevelopePerController

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelPay:) name:@"cancelPay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelChangePayWayView:) name:@"cancelChangePayWayView" object:nil];
    
}

/**
 *  键盘将要显示
 *
 *  @param notification 通知
 */
-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _keyHight = frame.size.height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    [self setNavigation_StyleTitle:@"发红包"];
    self.navigationItem.leftBarButtonItem = [self left_BarButtonItem];
    [self topViewBackGroundStylr];

    self.sendMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (10+98+50)*kScreen_H_Scale, kScreenWidth, 30*kScreen_H_Scale)];
    _sendMoneyLabel.text = @"￥0.00";
    _sendMoneyLabel.font = [UIFont boldSystemFontOfSize:36.f];
    _sendMoneyLabel.textColor = [UIColor blackColor];
    _sendMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_sendMoneyLabel];
    
    
    self.sendBtn = [UIButton buttonWithFrame:CGRectMake(15*kScreen_W_Scale, CGRectGetMaxY(_sendMoneyLabel.frame)+40*kScreen_H_Scale, kScreenWidth - 30*kScreen_W_Scale, 45*kScreen_H_Scale) andBackgroundColor:NAVIBGCOLOR andTitle:@"塞钱进红包" andTitleColor:[UIColor whiteColor] andBorderColor:nil andCornerRadius:5.f];
    [_sendBtn addTarget:self action:@selector(plugMoneyBtn:) forControlEvents:UIControlEventTouchUpInside];
    _sendBtn.alpha = 0.5;
    [_sendBtn setEnabled:NO];
    [self.view addSubview:_sendBtn];

    self.payWayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_sendBtn.frame)+20*kScreen_H_Scale, kScreenWidth, 25*kScreen_H_Scale)];
    
    _payWayLabel.text = @"使用账户余额付款,更换";
    _payWayLabel.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1];
    _payWayLabel.font = [UIFont systemFontOfSize:13.f];
    _payWayLabel.textAlignment = NSTextAlignmentCenter;
    [self modifyLabelSomeText:_payWayLabel string:_payWayLabel.text];
    _payWayLabel.userInteractionEnabled = YES;
    [self.view addSubview:_payWayLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modifyPayWay:)];
    [_payWayLabel addGestureRecognizer:tap];
    
    
}

-(void)modifyLabelSomeText:(UILabel *)label string:(NSString *)str{

    NSMutableAttributedString *hintString2=[[NSMutableAttributedString alloc]initWithString:str];
    NSRange range1=[[hintString2 string]rangeOfString:@"更换"];
    [hintString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:78/255.f green:180/255.f blue:238/255.f alpha:1] range:range1];
    label.attributedText = hintString2;

}




-(void)topViewBackGroundStylr{

    UIView *bgVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 10*kScreen_H_Scale, kScreenWidth, 98*kScreen_H_Scale)];
    bgVeiw.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgVeiw];

    UIView *moneyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44*kScreen_H_Scale)];
    moneyView.backgroundColor = [UIColor whiteColor];
    [bgVeiw addSubview:moneyView];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, 0, 60*kScreen_W_Scale, 44*kScreen_H_Scale)];
    moneyLabel.text = @"金额";
    moneyLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
    moneyLabel.font = [UIFont systemFontOfSize:15.f];
    [moneyView addSubview:moneyLabel];
    
    self.moneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel.frame), 0, kScreenWidth - (15+60+40)*kScreen_W_Scale, 44*kScreen_H_Scale)];
    _moneyTextField.placeholder = @"0.00";
    _moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    _moneyTextField.textAlignment = NSTextAlignmentRight;
    _moneyTextField.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
    _moneyTextField.delegate = self;
    [_moneyTextField addTarget:self action:@selector(redEnvelopeMoneyChange:) forControlEvents:UIControlEventEditingChanged];
    _moneyTextField.font = [UIFont systemFontOfSize:15.f];
    [_moneyTextField makeTextFieldPlaceholer];
    [moneyView addSubview:_moneyTextField];
    
    
    UILabel *yuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-30*kScreen_W_Scale, 0, 30*kScreen_W_Scale, 44*kScreen_W_Scale)];
    yuanLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
    yuanLabel.text = @"元";
    [moneyView addSubview:yuanLabel];
    
    
    UIView *markView = [[UIView alloc]initWithFrame:CGRectMake(0, bgVeiw.frame.size.height - 44*kScreen_H_Scale, kScreenWidth, 44*kScreen_H_Scale)];
    markView.backgroundColor = [UIColor whiteColor];
    [bgVeiw addSubview:markView];

    self.blessTextField = [[UITextField alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, 0, kScreenWidth - 30*kScreen_W_Scale, 44*kScreen_H_Scale)];
    _blessTextField.placeholder = @"恭喜发财，大吉大利";
    _blessTextField.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
    _blessTextField.font = [UIFont systemFontOfSize:15.f];
    [_blessTextField makeTextFieldPlaceholer];
    [_blessTextField addTarget:self action:@selector(blessTextChange:) forControlEvents:UIControlEventEditingChanged];
    _blessTextField.delegate = self;
    [markView addSubview:_blessTextField];
    
}

#pragma  mark --- 红包金额输入监听
-(void)redEnvelopeMoneyChange:(UITextField *)aTextField{

    if (_envelopeStr == nil) {
        _envelopeStr = [NSString string];
    }
    _envelopeStr = aTextField.text;
    _sendMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f",[aTextField.text floatValue]];
    
    if (aTextField.text.length > 0) {
        
        [_sendBtn setEnabled:YES];
        _sendBtn.alpha = 1.0;
    }else{
        [_sendBtn setEnabled:NO];
        _sendBtn.alpha = 0.5;
    
    }
    
}

#pragma mark ---- 祝福语文本编辑
-(void)blessTextChange:(UITextField *)aTextField{

    if (_blessStr == nil) {
        _blessStr = [NSString string];
    }
    _blessStr = aTextField.text;
    
}


#pragma mark UITextField  Delegate 
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == _moneyTextField) {
        
      BOOL isHaveDian = YES;
    //判断第一次输入的是不是小数点
        if (string.length > 0) {
            
            if ([string isEqualToString:@"."]) {
                
                if ([textField.text length] == 0) {
                    NSString *str = @"0";
                    textField.text =  [str stringByAppendingString:textField.text];
                }
            }
        }

        
      if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
      }
    
      if ([string isEqualToString:@"."]) {
        
        if (isHaveDian) {
           [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }else{
            isHaveDian = YES;
            
            return YES;
        }
      }else{
    
        if (isHaveDian) { //有小数点
            //判断小数点的位数
            NSRange ran = [textField.text rangeOfString:@"."];
            if (range.location - ran.location <= 2) {
                return YES;
            }else {
               // NSLog(@"最多两位小数");
                return NO;
            }
        }else{
            return YES;
        }
      }
        
  }
    
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    return [textField resignFirstResponder];
}

#pragma  mark ---- 塞钱进红包响应
-(void)plugMoneyBtn:(UIButton *)sender {

    NSLog(@"拆红包");
    [_moneyTextField resignFirstResponder];
    [_blessTextField resignFirstResponder];
    
    if (_payBgView == nil) {
        
        self.payBgView = [[PayPasswordView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) keyHeigh:self.keyHight];
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [window addSubview:_payBgView];
    }
    

}

#pragma  mark --- 更换红包结算方式
-(void)modifyPayWay:(UITapGestureRecognizer *)tap{

    [_moneyTextField resignFirstResponder];
    [_blessTextField resignFirstResponder];
    
    if (_changePayWayBgView == nil) {
        
        self.changePayWayBgView = [[ChangePayWayView alloc]initWithChangePayWayFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _changePayWayBgView.delegate = self;
        if (!self.changeIndex) {
            _changeIndex = 0;
        }
        self.changePayWayBgView.changeIndex = _changeIndex;
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [window addSubview:_changePayWayBgView];

        
    }
    
}

-(void)changePayWayTitle:(NSString *)title index:(NSInteger)index{

    _payWayLabel.text = [NSString stringWithFormat:@"使用%@付款,更换",title];
    [self modifyLabelSomeText:_payWayLabel string:_payWayLabel.text];
    self.changeIndex = index;

}

#pragma mark ---- 关闭支付界面
-(void)cancelPay:(NSNotification *)user{

    [UIView animateWithDuration:1.0 animations:^{
        
        _payBgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_payBgView removeFromSuperview];
         _payBgView = nil;
    }];

}

#pragma  mark  --- 关闭选择支付方式
-(void)cancelChangePayWayView:(NSNotification *)userid{

    [UIView animateWithDuration:1.0 animations:^{
        
        _changePayWayBgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_changePayWayBgView removeFromSuperview];
        _changePayWayBgView = nil;
    }];


}



-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cancelPay" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cancelChangePayWayView" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
