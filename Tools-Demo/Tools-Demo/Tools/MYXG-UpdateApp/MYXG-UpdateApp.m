//
//  MYXG-UpdateApp.m
//  Tools-Demo
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import "MYXG-UpdateApp.h"
#import "UIAlertController+MYXG.h"

@interface MYXG_UpdateApp ()

@property (nonatomic, copy) NSString *alertTitle;

@property (nonatomic, copy) NSString *alertMessage;

@property (nonatomic, copy) NSString *alertUpdateBtnTitle;

@property (nonatomic, copy) NSString *alertCancelBtnTitle;

@property (nonatomic, assign) NSInteger textAligment;

@end

@implementation MYXG_UpdateApp

#pragma mark - init

+ (id)sharedUpdater
{
    static MYXG_UpdateApp *sharedUpdater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUpdater = [[MYXG_UpdateApp alloc] init];
        
    });
    return sharedUpdater;

}

- (id)init
{
    self = [super init];
    if (self) {
        self.alertTitle = @"更新提示";
        self.alertMessage = @"新版本%@已经上线，快来更新吧!\n\n%@";
        self.alertUpdateBtnTitle = @"前往更新";
        self.alertCancelBtnTitle = @"暂不更新";
        self.textAligment = UIBaselineAdjustmentAlignCenters;
    }
    return self;
}

#pragma mark - public Methods

- (void)showUpdateWithMessageAligment:(NSInteger)textAligement
{
    
    self.textAligment = textAligement;

    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self checkNewAppVersion:^(BOOL newVersion, NSString *version, NSString *releaseNotes) {
        if (newVersion) {
            [self showWithVersion:version releaseNotes:releaseNotes];
        }
    }];
}

#pragma mark - privte Methods

- (void)showWithVersion:(NSString *)version releaseNotes:(NSString *)releaseNotes
{
    UIAlertController *alert = [self alertUpdateForVersion:version releaseNotes:releaseNotes];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
}

- (BOOL)hasConnection
{
    const char *host = "itunes.apple.com";
    BOOL reachable;
    BOOL success;
    
    // Link SystemConfiguration.framework! <SystemConfiguration/SystemConfiguration.h>
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    reachable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    return reachable;
}

NSString *appStoreURL = nil;

- (void)checkNewAppVersion:(void(^)(BOOL newVersion, NSString *version, NSString *releaseNotes))completion
{
    
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = bundleInfo[@"CFBundleShortVersionString"];
    NSURL *lookupURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", KAPPID]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
        
        NSData *lookupResults = [NSData dataWithContentsOfURL:lookupURL];
        if (!lookupResults) {
            completion(NO, nil, nil);
            return;
        }
        
        NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:lookupResults options:0 error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            NSUInteger resultCount = [jsonResults[@"resultCount"] integerValue];
            if (resultCount){
                NSDictionary *appDetails = [jsonResults[@"results"] firstObject];
                NSString *appItunesUrl = [appDetails[@"trackViewUrl"] stringByReplacingOccurrencesOfString:@"&uo=4" withString:@""];
                NSString *latestVersion = appDetails[@"version"];
                NSString *releaseNotes = appDetails[@"releaseNotes"];  //更新内容
                if ([latestVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                    appStoreURL = appItunesUrl;
                    completion(YES, latestVersion, releaseNotes);
                } else {
                    completion(NO, nil, nil);
                }
            } else {
                completion(NO, nil, nil);
            }
        });
    });
}

- (UIAlertController *)alertUpdateForVersion:(NSString *)version releaseNotes:releaseNotes
{
    NSString *msg = [NSString stringWithFormat:self.alertMessage, version, releaseNotes];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.alertTitle message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert setupAlertControllerWithTextAlignment:self.textAligment];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:self.alertCancelBtnTitle style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:self.alertUpdateBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goToAppleStore];
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    return alert;
}

- (void)goToAppleStore
{
    NSURL *appUrl = [NSURL URLWithString:appStoreURL];
    if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
        [[UIApplication sharedApplication] openURL:appUrl];
    } else {
        UIAlertView *cantOpenUrlAlert = [[UIAlertView alloc] initWithTitle:@"网络君抽风了" message:@"不能连接苹果商店，请稍后重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [cantOpenUrlAlert show];
    }
}

@end
