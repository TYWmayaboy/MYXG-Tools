//
//  CirclePercent.h
//  SJDApp
//
//  Created by apple on 16/2/10.
//  Copyright © 2016年 agewnetLV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirclePercent : UIView



@property (nonatomic,retain)UIColor *bgcolor;
@property (nonatomic,retain)UIColor *frcolor;

@property (nonatomic,assign)CGFloat percent;

-(id)initWithFrame:(CGRect)frame Percent :(CGFloat )percent frColor:(UIColor *)frcolor bgColor:(UIColor *)bgcolor;

@end
