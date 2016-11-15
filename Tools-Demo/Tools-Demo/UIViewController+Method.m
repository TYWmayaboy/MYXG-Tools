//
//  UIViewController+Method.m
//  Tools-Demo
//
//  Created by apple on 2016/11/15.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import "UIViewController+Method.h"
#import "UIAlertController+MYXG.h"

@implementation UIViewController (Method)

- (void)showAlertView:(NSString *)textAligment
{
    /*
     UIBaselineAdjustmentNone  左对齐
     UIBaselineAdjustmentAlignBaselines  右对齐
     UIBaselineAdjustmentAlignCenters  居中
     */

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"MXYG" message:@"修改内容的样式" preferredStyle:UIAlertControllerStyleAlert];
    [alert setupAlertControllerWithTextAlignment:UIBaselineAdjustmentAlignBaselines];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
    
}

@end
