//
//  UIViewController+Method.m
//  Tools-Demo
//
//  Created by apple on 2016/11/15.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import "UIViewController+Method.h"
#import "UIAlertController+MYXG.h"
#import "MYXG-UpdateApp.h"
#import "LBToAppStore.h"
#import "SJDFilterTool.h"
#import "ChangePageView.h"

@implementation UIViewController (Method)

- (void)showUpdate
{
    [[MYXG_UpdateApp sharedUpdater] showUpdateWithMessageAligment:UIBaselineAdjustmentAlignBaselines];
}

- (void)showAlertView
{
    /*
     UIBaselineAdjustmentNone  右对齐
     UIBaselineAdjustmentAlignBaselines 左对齐
     UIBaselineAdjustmentAlignCenters  居中
     */

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"MXYG" message:@"修改内容的样式" preferredStyle:UIAlertControllerStyleAlert];
    [alert setupAlertControllerWithTextAlignment:UIBaselineAdjustmentNone];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)showGotoComment
{
    LBToAppStore *toAppStore = [[LBToAppStore alloc]init];
    toAppStore.myAppID = KAPPID;
    [toAppStore showGotoAppStore:self];

}

-(void)showQRCode
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [SJDFilterTool creatCIQRCodeImage:imageView str:@"https://github.com/TYWmayaboy/MYXG-Tools.git"];
    imageView.bounds = CGRectMake(0, 0, 100, 100);
    imageView.center = viewController.view.center;
    [viewController.view addSubview:imageView];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showChangePageView
{
    NSLog(@"麻烦，自己看");
}

@end
