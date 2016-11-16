//
//  MYXG-UpdateApp.h
//  Tools-Demo
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>

//https://itunes.apple.com/us/app/li-wu-shuo-li-wu-he-quan-qiu/id834149344?mt=8
#define KAPPID @"834149344"

@interface MYXG_UpdateApp : NSObject
+ (id)sharedUpdater;
- (void)showUpdateWithMessageAligment:(NSInteger)textAligement;
@end
