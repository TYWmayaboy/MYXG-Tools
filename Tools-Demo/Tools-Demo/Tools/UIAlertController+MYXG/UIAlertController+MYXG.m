//
//  UIAlertController+MYXG.m
//  Tools-Demo
//
//  Created by apple on 2016/11/15.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import "UIAlertController+MYXG.h"

@implementation UIAlertController (MYXG)

- (void)setupAlertControllerWithTextAlignment:(NSInteger)textAlignment
{
    //找到alertViewController中的message的label
    UIView *view = self.view.subviews[0];
    while (![view.subviews[0] isKindOfClass:[UILabel class]]) {
        view = view.subviews[0];
    }
    UILabel *lab = view.subviews[1];
    lab.textAlignment = textAlignment;

}
@end
