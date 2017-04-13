//
//  UIViewController+Navigat.m
//  RedEnvelope
//
//  Created by mengdy on 17/4/10.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "UIViewController+Navigat.h"
#import <objc/runtime.h>
#import "UIColor+Expanded.h"
#import "UITextField+EXStyle.h"

@implementation UIViewController (Navigat)


- (UIBarButtonItem *)left_BarButtonItem
{
    UIBarButtonItem *leftItem = objc_getAssociatedObject(self, _cmd);
    
    if (!leftItem) {
        
        leftItem = [[UIBarButtonItem alloc]init];
        objc_setAssociatedObject(self, _cmd, leftItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        UIImage *image = [UIImage imageNamed:@"back_arrow"];
        
        UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, image.size.width ,image.size.height)];
        [back setImage:image forState:UIControlStateNormal];
        [back addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
        
        leftItem.customView = back;
    }
    return leftItem;
}

-(void)backView:(UIButton *)backBtn {

    [self.navigationController popViewControllerAnimated:YES];

}

-(void)setNavigation_StyleTitle:(NSString *)title{

    UIImage *iamge = [self imageWithColor:NAVIBGCOLOR];
    [self.navigationController.navigationBar setBackgroundImage:[iamge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}];

}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}



@end
