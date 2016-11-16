//
//  SJDFilterTool.m
//  SJDApp
//
//  Created by Tam on 16/7/19.
//  Copyright © 2016年 agewnetLV. All rights reserved.
//

#import "SJDFilterTool.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+SJD.h"

@implementation SJDFilterTool

/**
 *  生成二维码
 */
+(void)creatCIQRCodeImage:(UIImageView *)imgView str:(NSString *)str
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3. 给过滤器添加数据
    NSString *dataString = str;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5. 显示二维码
//    imgView.image = [UIImage imageWithCIImage:outputImage];
    imgView.image = [UIImage creatNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
}

@end
