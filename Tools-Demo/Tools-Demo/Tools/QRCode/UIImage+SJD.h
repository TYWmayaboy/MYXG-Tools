//
//  UIImage+SJD.h
//  SJDApp
//
//  Created by Tam on 16/6/23.
//  Copyright © 2016年 agewnetLV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SJD)

+(UIImage*) createImageWithColor: (UIColor*) color;

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;


@end
