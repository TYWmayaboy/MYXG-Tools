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
#import "CustomAlertView.h"
#import "CirclePercent.h"
#import "EnumClass.h"

@implementation UIViewController (Method)

//app更新提示
- (void)showUpdate
{
    [[MYXG_UpdateApp sharedUpdater] showUpdateWithMessageAligment:UIBaselineAdjustmentAlignBaselines];
}

//对齐样式
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

//引导用户评价
- (void)showGotoComment
{
    LBToAppStore *toAppStore = [[LBToAppStore alloc]init];
    toAppStore.myAppID = KAPPID;
    [toAppStore showGotoAppStore:self];

}

//生成二维码
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

//换页按钮
- (void)showChangePageView
{
    NSLog(@"麻烦，自己看");
}

//自定义AlertView
- (void)showCustomAlertView
{
   CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"测试" message:@"测试内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
    
}

//圆形百分比
- (void)showCirclePercent
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    CirclePercent *circle = [[CirclePercent alloc] initWithFrame:CGRectMake(0, 0, 100, 100) Percent:50 frColor:[UIColor redColor] bgColor:[UIColor yellowColor]];
    circle.center = viewController.view.center;
    [viewController.view addSubview:circle];
    
    [self.navigationController pushViewController:viewController animated:YES];

}

//校验、时间格式转换
- (void)showTool
{
    [[[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"暂无demo" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil] show];
}

//直接使用枚举值字符串
- (void)showEnum
{
    //可以直接将键转化为字符串使用
    NSString *str = [NSString stringWithFormat:@"%s", UMSocialPlatform[UMSocialPlatformType_Instagram]];
    str = [str componentsSeparatedByString:@"_"][1];
    str = [str componentsSeparatedByString:@"="].firstObject;
    NSLog(@"%s", UMSocialPlatform[UMSocialPlatformType_Instagram]);
    NSLog(@"%@", str);
}
@end
