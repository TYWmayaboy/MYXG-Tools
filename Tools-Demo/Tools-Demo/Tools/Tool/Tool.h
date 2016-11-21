//
//  Tool.h
//  Tools-Demo
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tool : NSObject

/**
 *验证手机号码
 *mobile验证的手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**
 *验证电话号码
 *mobile验证的电话号码
 */
+ (BOOL)Phone:(NSString *)phone;

/**
 *验证电子邮箱
 *email验证的电子邮箱
 */
+ (BOOL)validateEmail:(NSString *)email;

//字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;

//字符串文字的高度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;

//获取今天的日期：年月日
+(NSDictionary *)getTodayDate;

//车牌号验证
+ (BOOL)justCarNo:(NSString *)carNo;

//车型
+ (BOOL)justCarType:(NSString *)CarType;

//用户名
+ (BOOL)justUserName:(NSString *)name;

//密码
+ (BOOL)justPassword:(NSString *)passWord;

//昵称
+ (BOOL)justNickname:(NSString *)nickname;

//身份证号
+ (BOOL)justIdentityCard: (NSString *)identityCard;



+(BOOL)passwordRuleLength:(NSString*)password;

// date 格式化为 string
+ (NSString*)stringFromFomate:(NSDate*)date formate:(NSString*)formate;

// string 格式化为 date
+(NSDate *)dateFromDateStr:(NSString *)datestring formate:(NSString*)formate;

//字符串日期转换成有一定格式的日期字符串
+ (NSString *)fomateString:(NSString *)datestring;

//时间戳TO:::yyyy-MM-dd HH:mm:ss
+(long)getCurrentTimeStamp;

+(NSString *)timeStampToDateString:(NSString *)datestring;

+(NSString *)changeTimeWithStr:(NSString *)dateString;

+(NSString *)changeTimeWithStr2:(NSString *)dateString;

+(NSString *)makeClockChooseTimeStr:(int) time;

@end
