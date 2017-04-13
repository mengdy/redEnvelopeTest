//
//  SendEnvelopeGroController.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/12.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "SendEnvelopeGroController.h"
#import "UIViewController+Navigat.h"
#import "UIColor+Expanded.h"
#import "UIButton+SMButton.h"
#import "NSString+Size.h"
#import "UITextField+EXStyle.h"
#import "UILabel+AddPic.h"
#import "UIView+Toast.h"

#import "PayPasswordView.h"

static NSString *currNorEnveStr     =    @"当前为普通红包,";
static NSString *currLuckEnveStr    =    @"当前为拼手气红包,";
static NSString *modifyNorEnveStr   =    @"改为普通红包";
static NSString *modifyLuckEnveStr  =    @"改为拼手气红包";



@interface SendEnvelopeGroController ()<UITextFieldDelegate,finishPasswordPayDelegate>

@property (strong, nonatomic)UIView       *countView;
@property (strong, nonatomic)UILabel      *gEnveCountLabel;
@property (strong, nonatomic)UILabel      *geLabel;
@property (strong, nonatomic)UITextField  *gEnveCouTextField;

@property (nonatomic,strong)UILabel       *gGroPeLabel;


@property (strong, nonatomic)UIView       *envelopeMoneyView;
@property (strong, nonatomic)UILabel      *gEnveTotalAmountLabel;
@property (strong, nonatomic)UILabel      *yuanLabel;
@property (strong ,nonatomic)UITextField  *gEnveAmountTextField;


@property (nonatomic,strong)UILabel       *currEnveStyleLabel;
@property (strong, nonatomic)UIButton     *modifyEnveStyleBtn;

@property (strong, nonatomic)UIView       *luckView;
@property (strong, nonatomic)UITextField  *luckTextField;

@property (strong, nonatomic)UILabel      *totalAmountLabel;

@property (nonatomic,strong)UIButton *sendBtn;

@property (nonatomic, strong)PayPasswordView  *payView;
@property (nonatomic,assign)CGFloat  keyHight;

@end

@implementation SendEnvelopeGroController

-(instancetype)init{

    self = [super init];
    if (self) {
        
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelPay:) name:@"cancelPay" object:nil];
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
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.navigationItem.leftBarButtonItem = [self left_BarButtonItem];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setNavigation_StyleTitle:@"发红包"];
    //当前为拼手气红包
    self.isLuck = YES;

    //红包个数
    [self setRedEnvelopeCountView];
    
       //本群人数
   self.gGroPeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, CGRectGetMaxY(_countView.frame), kScreenWidth - 30*kScreen_W_Scale, 35*kScreen_H_Scale)];
    _gGroPeLabel.text = @"本群共3人";
    _gGroPeLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _gGroPeLabel.backgroundColor = [UIColor clearColor];
    _gGroPeLabel.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:_gGroPeLabel];
    
    //红包总金额
    [self redEnvelopeTotalAmountView];
    
    //选择普通还是拼手气
    [self chooseSendRedEnvelopeStyleView];
    
    if (_luckView == nil) {
        
        self.luckView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_modifyEnveStyleBtn.frame)+15*kScreen_H_Scale, kScreenWidth, 44*kScreen_H_Scale)];
        _luckView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_luckView];
        
        if (_luckTextField == nil) {
            
            self.luckTextField = [[UITextField alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, 0, kScreenWidth - 30*kScreen_W_Scale, 44*kScreen_H_Scale)];
            _luckTextField.placeholder = @"恭喜发财，大吉大利";
            _luckTextField.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
            _luckTextField.font = [UIFont systemFontOfSize:15.f];
            [_luckTextField makeTextFieldPlaceholer];
            [_luckTextField addTarget:self action:@selector(luckTextChange:) forControlEvents:UIControlEventEditingChanged];
            _luckTextField.delegate = self;
            [_luckView addSubview:_luckTextField];
        }

    }
    
    if (_totalAmountLabel == nil) {
        
        CGSize size = [NSString sizeWithText:@"￥88.88" font:30.f textColor:@"333333"];
        self.totalAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_luckView.frame)+55*kScreen_H_Scale, kScreenWidth, size.height)];
        _totalAmountLabel.text = @"￥0.00";
        _totalAmountLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _totalAmountLabel.font = [UIFont systemFontOfSize:30.f];
        _totalAmountLabel.textAlignment = NSTextAlignmentCenter;
        _totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:_totalAmountLabel.text];
        [self.view addSubview:_totalAmountLabel];

    }
    
    if (_sendBtn == nil) {
     self.sendBtn = [UIButton buttonWithFrame:CGRectMake(15*kScreen_W_Scale, CGRectGetMaxY(_totalAmountLabel.frame)+40*kScreen_H_Scale, kScreenWidth - 30*kScreen_W_Scale, 45*kScreen_H_Scale) andBackgroundColor:NAVIBGCOLOR andTitle:@"塞钱进红包" andTitleColor:[UIColor whiteColor] andBorderColor:nil andCornerRadius:5.f];
     [_sendBtn addTarget:self action:@selector(group_plugMoneyBtn:) forControlEvents:UIControlEventTouchUpInside];
     _sendBtn.alpha = 0.5;
     [_sendBtn setEnabled:NO];
     [self.view addSubview:_sendBtn];
    }

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shouldReturnKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
    
    
    
}

//红包个数的
-(void)setRedEnvelopeCountView{
    CGSize yuanSize = [NSString sizeWithText:@"个" font:15.f textColor:@"333333"];
    //红包个数
    if (_countView == nil) {
        
        self.countView = [[UIView alloc]initWithFrame:CGRectMake(0, 10*kScreen_H_Scale, kScreenWidth, 44*kScreen_H_Scale)];
        _countView.backgroundColor = [UIColor whiteColor];
        _countView.userInteractionEnabled = YES;
        [self.view addSubview:_countView];
    }
    if (_gEnveCountLabel == nil) {
        
        self.gEnveCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, 0, 120*kScreen_W_Scale, 44*kScreen_H_Scale)];
        _gEnveCountLabel.text = @"红包个数";
        _gEnveCountLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _gEnveCountLabel.font = [UIFont systemFontOfSize:15.f];
        [_countView addSubview:_gEnveCountLabel];
    }
    
    if (_geLabel == nil) {
        self.geLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-15*kScreen_W_Scale-yuanSize.width, (44*kScreen_H_Scale-yuanSize.height)/2.f, yuanSize.width, yuanSize.height)];
        _geLabel.text = @"个";
        _geLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _geLabel.font = [UIFont systemFontOfSize:15.f];
        [_countView addSubview:_geLabel];
    }
    
    if (_gEnveCouTextField == nil) {
        
        self.gEnveCouTextField = [[UITextField alloc]initWithFrame:CGRectMake(135*kScreen_W_Scale, 0, kScreenWidth - 160*kScreen_W_Scale-yuanSize.width, 44*kScreen_H_Scale)];
        _gEnveCouTextField.textColor = [UIColor colorWithHexString:@"333333"];
        _gEnveCouTextField.font = [UIFont systemFontOfSize:15.f];
        [_gEnveCouTextField makeTextFieldPlaceholer];
        _gEnveCouTextField.placeholder = @"填写个数";
        _gEnveCouTextField.textAlignment = NSTextAlignmentRight;
        _gEnveCouTextField.delegate = self;
        _gEnveCouTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_gEnveCouTextField addTarget:self action:@selector(puIntRedEnvelopeCount:) forControlEvents:UIControlEventEditingChanged];
        [_countView addSubview:_gEnveCouTextField];
    }
    
}

//红包总金额
-(void)redEnvelopeTotalAmountView{

    //红包总金额
    CGSize yuanSize = [NSString sizeWithText:@"个" font:15.f textColor:@"333333"];
    if (_envelopeMoneyView == nil) {
        
        self.envelopeMoneyView = [[UIView alloc]initWithFrame:CGRectMake(0,89*kScreen_H_Scale , kScreenWidth, 44*kScreen_H_Scale)];
        _envelopeMoneyView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_envelopeMoneyView];
    }
    
    if (_gEnveTotalAmountLabel == nil) {
        
        self.gEnveTotalAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, 0, 120*kScreen_W_Scale, 44*kScreen_H_Scale)];
        _gEnveTotalAmountLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _gEnveTotalAmountLabel.font = [UIFont systemFontOfSize:15.f];
        _gEnveTotalAmountLabel.attributedText = [UILabel addPicInLabelRight:@"pin" textTitle:@"总金额 "];
       
        [_envelopeMoneyView addSubview:_gEnveTotalAmountLabel];
    }
    
    if (_yuanLabel == nil) {
        
        self.yuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-15*kScreen_W_Scale-yuanSize.width, (44*kScreen_H_Scale-yuanSize.height)/2.f, yuanSize.width, yuanSize.height)];
        _yuanLabel.text = @"元";
        _yuanLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _yuanLabel.font = [UIFont systemFontOfSize:15.f];
        [_envelopeMoneyView addSubview:_yuanLabel];
        
    }
    
    if (_gEnveAmountTextField == nil) {
        
        self.gEnveAmountTextField = [[UITextField alloc]initWithFrame:CGRectMake(135*kScreen_W_Scale, 0, kScreenWidth - 160*kScreen_W_Scale-yuanSize.width, 44*kScreen_H_Scale)];
        _gEnveAmountTextField.textColor = [UIColor colorWithHexString:@"333333"];
        _gEnveAmountTextField.font = [UIFont systemFontOfSize:15.f];
        [_gEnveAmountTextField makeTextFieldPlaceholer];
        _gEnveAmountTextField.placeholder = @"0.00";
        _gEnveAmountTextField.textAlignment = NSTextAlignmentRight;
        _gEnveAmountTextField.delegate = self;
        _gEnveAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
        [_gEnveAmountTextField addTarget:self action:@selector(enterRedEnvelopeAmount:) forControlEvents:UIControlEventEditingChanged];
        [_envelopeMoneyView addSubview:_gEnveAmountTextField];
    }
}

//选择红包的类型
-(void)chooseSendRedEnvelopeStyleView{

    if (_currEnveStyleLabel == nil) {
        CGSize size = [NSString sizeWithText:currLuckEnveStr font:14.f textColor:@"999999"];
        self.currEnveStyleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15*kScreen_W_Scale, (95+44)*kScreen_H_Scale, size.width, size.height)];
        _currEnveStyleLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _currEnveStyleLabel.font = [UIFont systemFontOfSize:14.f];
        _currEnveStyleLabel.text = currLuckEnveStr;
        [self.view addSubview:_currEnveStyleLabel];
    }
    if (_modifyEnveStyleBtn == nil) {
        
        CGSize size = [NSString sizeWithText:modifyNorEnveStr font:14.f textColor:@"4eb4ee"];
        self.modifyEnveStyleBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_currEnveStyleLabel.frame), CGRectGetMinY(_currEnveStyleLabel.frame), size.width, size.height)];
        [_modifyEnveStyleBtn setTitleColor:[UIColor colorWithHexString:@"4eb4ee"] forState:UIControlStateNormal];
        _modifyEnveStyleBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_modifyEnveStyleBtn setTitle:modifyNorEnveStr forState:UIControlStateNormal];
        [_modifyEnveStyleBtn addTarget:self action:@selector(modifyEnveStyleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_modifyEnveStyleBtn];
        
    }
}

-(NSMutableAttributedString * )redEnvelopeTotalAmountStyle:(NSString *)title{
    
    NSMutableAttributedString *hintString2=[[NSMutableAttributedString alloc]initWithString:title];
    NSRange range1=[[hintString2 string]rangeOfString:@"￥"];
    [hintString2 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"],NSFontAttributeName:[UIFont systemFontOfSize:18.f]} range:range1];
    return  hintString2;
    
}

#pragma mark --- 修改红包的类型
-(void)modifyEnveStyleClick:(UIButton *)sender{
    
    NSArray *array = [self.totalAmountLabel.text componentsSeparatedByString:@"￥"];
    NSString *money = [array lastObject];
    NSInteger count = [self.gEnveCouTextField.text integerValue];
    
    if ([money isEqualToString:@"0.00"] || [self.gEnveCouTextField.text isEqualToString:@""] || self.gEnveCouTextField.text == nil) {
        [self.sendBtn setEnabled:NO];
        self.sendBtn.alpha = 0.5;
    }else{
        [self.sendBtn setEnabled:YES];
        self.sendBtn.alpha = 1.0;
    }
    
    
    if (_isLuck) {
        CGSize curSize = [NSString sizeWithText:currNorEnveStr font:14.f textColor:@"999999"];
        self.currEnveStyleLabel.frame = CGRectMake(15*kScreen_W_Scale, (95+44)*kScreen_H_Scale, curSize.width, curSize.height);
       CGSize  modifySize = [NSString sizeWithText:modifyLuckEnveStr font:14.f textColor:@"4eb4ee"];
        self.modifyEnveStyleBtn.frame = CGRectMake(CGRectGetMaxX(_currEnveStyleLabel.frame), CGRectGetMinY(_currEnveStyleLabel.frame), modifySize.width, modifySize.height);
    
        self.currEnveStyleLabel.text = currNorEnveStr;
        [self.modifyEnveStyleBtn setTitle:modifyLuckEnveStr forState:UIControlStateNormal];
        _isLuck = NO;
        self.gEnveTotalAmountLabel.attributedText = [UILabel addPicInLabelRight:@"pu" textTitle:@"单个金额 "];
        
        if ([self.gEnveCouTextField.text isEqualToString:@""] || self.gEnveCouTextField.text == nil) {
            if ([self.gEnveAmountTextField.text isEqualToString:@""] || self.gEnveAmountTextField.text == nil) {
                
                NSLog(@"普通红包 红包个数  和  单价金额都是空");
            }else{
            
                NSLog(@"普通红包 红包个数为空，单价有值");
               self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:[NSString stringWithFormat:@"￥0.00"]];
            }
        }else{
        
            if ([self.gEnveAmountTextField.text isEqualToString:@""] || self.gEnveAmountTextField.text == nil) {
                
                NSLog(@"普通红包 红包个数有值，单个金额为空");
            }else {
                NSLog(@"普通红包 红包单个金额 和 红包个数均有值");
                if ([money isEqualToString:@""]) {
                    NSLog(@"总金额为0");
                   // self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:[NSString stringWithFormat:@"￥%0.2f",(count * moneys)]];

                }else{
                    NSLog(@"总金额不为空:%@",money);
                    CGFloat priceMoney = [money floatValue] / count;
                    self.gEnveAmountTextField.text = [NSString stringWithFormat:@"%0.2f",priceMoney];
                    self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:[NSString stringWithFormat:@"￥%0.2f",[[NSString stringWithFormat:@"%0.2f",priceMoney] floatValue]*count]];
                }
            }
        }
       
    }else{
        
        CGSize curSize = [NSString sizeWithText:currLuckEnveStr font:14.f textColor:@"999999"];
        self.currEnveStyleLabel.frame = CGRectMake(15*kScreen_W_Scale, (95+44)*kScreen_H_Scale, curSize.width, curSize.height);
        CGSize  modifySize = [NSString sizeWithText:modifyNorEnveStr font:14.f textColor:@"4eb4ee"];
        self.modifyEnveStyleBtn.frame = CGRectMake(CGRectGetMaxX(_currEnveStyleLabel.frame), CGRectGetMinY(_currEnveStyleLabel.frame), modifySize.width, modifySize.height);
        self.currEnveStyleLabel.text = currLuckEnveStr;
        [self.modifyEnveStyleBtn setTitle:modifyNorEnveStr forState:UIControlStateNormal];
         self.gEnveTotalAmountLabel.attributedText = [UILabel addPicInLabelRight:@"pin" textTitle:@"总金额 "];
        
        self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:[NSString stringWithFormat:@"￥%0.2f",[self.gEnveAmountTextField.text floatValue]]];
        _isLuck = YES;
        
        if ([self.gEnveCouTextField.text isEqualToString:@""] || self.gEnveCouTextField.text == nil) {
            if ([self.gEnveAmountTextField.text isEqualToString:@""] || self.gEnveAmountTextField.text == nil) {
                
                NSLog(@"拼手气红包 红包个数  和  总金额都是空");
            }else{
                
                NSLog(@"拼手气红包 红包个数为空，总金额有值");
                
                if ([money isEqualToString:@""]) {
                    NSLog(@"总金额为0");
                    self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:[NSString stringWithFormat:@"￥%@",[NSString stringWithFormat:@"%0.2f",[self.gEnveAmountTextField.text floatValue]]]];

                }else{
                    NSLog(@"总金额不为空:%@",money);
                    //self.gEnveAmountTextField.text = money;
                }
            }
        }else{
            
            if ([self.gEnveAmountTextField.text isEqualToString:@""] || self.gEnveAmountTextField.text == nil) {
                
                NSLog(@"拼手气红包 红包个数有值，总金额为空");
                
            }else {
                
                NSLog(@"拼手气红包 红包总金额 和 红包个数均有值");
                
                if ([money isEqualToString:@""]) {
                    
                    
                }else{
                
                    self.gEnveAmountTextField.text = [NSString stringWithFormat:@"%@",money];
                    self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:[NSString stringWithFormat:@"￥%@",money]];
                }
                
            }
        }
    }
 }

#pragma  mark --- 发红包
-(void)group_plugMoneyBtn : (UIButton *)sender {

    /*  //提示语
    NSArray *array = [self.totalAmountLabel.text componentsSeparatedByString:@"￥"];
    NSString *money = [array lastObject];

    if ([self.gEnveCouTextField.text isEqualToString:@""] || self.gEnveCouTextField.text == nil) {
        [self.view makeToast:@"红包个数不能为空" duration:1.f position:@"CSToastPositionCenter"];
    }
    if ([money isEqualToString:@"0.00"]) {
        [self.view makeToast:@"红包金额不能小于0元" duration:1.f position:@"CSToastPositionCenter"];
    }
  */
    
    [self shouldReturnKeyBoard];
    if (_payView == nil) {
        
        self.payView = [[PayPasswordView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) keyHeigh:self.keyHight];
        _payView.delegate = self;
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [window addSubview:_payView];
    }
    
}

-(void)putInPaswordFinish{

    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark ---- 关闭支付界面
-(void)cancelPay:(NSNotification *)user{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        _payView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_payView removeFromSuperview];
        _payView = nil;
    }];
    
}


#pragma UITextField  delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
    if (_gEnveAmountTextField == textField) {
        
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

#pragma  mark -- 祝福语
-(void)luckTextChange: (UITextField *)aTextField{



}

#pragma  mark --- 输入红包金额
-(void)enterRedEnvelopeAmount : (UITextField *)aTextField{

    if (_isLuck) {
        NSLog(@"拼手气红包，输入金额");
       self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:[NSString stringWithFormat:@"￥%0.2f",[_gEnveAmountTextField.text floatValue]]];
        
    }else{
        
        if ([self.gEnveCouTextField.text isEqualToString:@""] || (self.gEnveCouTextField.text == nil)) {
        NSLog(@"普通红包，红包个数为空  输入金额");
        }else{
            NSLog(@"普通红包，红包个数不为空，输入金额");
            NSInteger count = [self.gEnveCouTextField.text integerValue];
            CGFloat   moneys = [self.gEnveAmountTextField.text floatValue];
            NSString *moneyStr = [NSString stringWithFormat:@"￥%0.2f",count*moneys];
            self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:moneyStr];
        }
    }
    NSArray *array = [self.totalAmountLabel.text componentsSeparatedByString:@"￥"];
    NSString *money = [array lastObject];
    
    if ([money isEqualToString:@"0.00"] || [self.gEnveCouTextField.text isEqualToString:@""] || self.gEnveCouTextField.text == nil) {
        [self.sendBtn setEnabled:NO];
        self.sendBtn.alpha = 0.5;
    }else{
        [self.sendBtn setEnabled:YES];
        self.sendBtn.alpha = 1.0;
    }

    
}

#pragma  mark --- 输入红包的个数
-(void)puIntRedEnvelopeCount : (UITextField *)aTextField{


    if (_isLuck) {
        
        if ([_gEnveAmountTextField.text isEqualToString:@""] || _gEnveAmountTextField.text == nil) {
            NSLog(@"拼手气红包，输入红包个数，红包总金额为空");
        }else{
            NSLog(@"拼手气红包，输入红包个数，总金额有值");
            self.totalAmountLabel.attributedText =[self redEnvelopeTotalAmountStyle: [NSString stringWithFormat:@"￥%0.2f",[_gEnveAmountTextField.text floatValue]]];
        }
        
    }else{
        if ([_gEnveAmountTextField.text isEqualToString:@""] || (_gEnveAmountTextField.text == nil)) {
            NSLog(@"普通红包，输入红包个数，红包单价无值");
        }else{
            NSLog(@"普通红包，输入红包个数，红包单价有值");
            NSInteger count = [self.gEnveCouTextField.text integerValue];
            CGFloat   moneys = [self.gEnveAmountTextField.text floatValue];
            NSString *moneyStr = [NSString stringWithFormat:@"￥%0.2f",count*moneys];
            self.totalAmountLabel.attributedText = [self redEnvelopeTotalAmountStyle:moneyStr];
        }
    }
    NSArray *array = [self.totalAmountLabel.text componentsSeparatedByString:@"￥"];
    NSString *money = [array lastObject];
    
    if ([money isEqualToString:@"0.00"] || [aTextField.text isEqualToString:@""]) {
        [self.sendBtn setEnabled:NO];
        self.sendBtn.alpha = 0.5;
    }else{
        [self.sendBtn setEnabled:YES];
        self.sendBtn.alpha = 1.0;
    }

}
#pragma  mark --- 回收键盘
-(void)shouldReturnKeyBoard{

    [_gEnveAmountTextField resignFirstResponder];
    [_gEnveCouTextField    resignFirstResponder];
    [_luckTextField        resignFirstResponder];

}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cancelPay" object:nil];

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
