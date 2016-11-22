//
//  EnumClass.h
//  Tools-Demo
//
//  Created by apple on 2016/11/22.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import <Foundation/Foundation.h>

//通过以下方法来使用枚举中的字符串

//这里使用友盟分享中的枚举来展示

//---------------------------------------友盟枚举-start-----------------------------------------------
//typedef NS_ENUM(NSInteger,UMSocialPlatformType)
//{
//    UMSocialPlatformType_UnKnown            = -2,
//    //预定义的平台
//    UMSocialPlatformType_Predefine_Begin    = -1,
//    UMSocialPlatformType_Sina               = 0, //新浪
//    UMSocialPlatformType_WechatSession      = 1, //微信聊天
//    UMSocialPlatformType_WechatTimeLine     = 2,//微信朋友圈
//    UMSocialPlatformType_WechatFavorite     = 3,//微信收藏
//    UMSocialPlatformType_QQ                 = 4,//QQ聊天页面
//    UMSocialPlatformType_Qzone              = 5,//qq空间
//    UMSocialPlatformType_TencentWb          = 6,//腾讯微博
//    UMSocialPlatformType_AlipaySession      = 7,//支付宝聊天页面
//    UMSocialPlatformType_YixinSession       = 8,//易信聊天页面
//    UMSocialPlatformType_YixinTimeLine      = 9,//易信朋友圈
//    UMSocialPlatformType_YixinFavorite      = 10,//易信收藏
//    UMSocialPlatformType_LaiWangSession     = 11,//点点虫（原来往）聊天页面
//    UMSocialPlatformType_LaiWangTimeLine    = 12,//点点虫动态
//    UMSocialPlatformType_Sms                = 13,//短信
//    UMSocialPlatformType_Email              = 14,//邮件
//    UMSocialPlatformType_Renren             = 15,//人人
//    UMSocialPlatformType_Facebook           = 16,//Facebook
//    UMSocialPlatformType_Twitter            = 17,//Twitter
//    UMSocialPlatformType_Douban             = 18,//豆瓣
//    UMSocialPlatformType_KakaoTalk          = 19,//KakaoTalk（暂未支持）
//    UMSocialPlatformType_Pinterest          = 20,//Pinterest（暂未支持）
//    UMSocialPlatformType_Line               = 21,//Line
//
//    UMSocialPlatformType_Linkedin           = 22,//领英
//
//    UMSocialPlatformType_Flickr             = 23,//Flickr
//
//    UMSocialPlatformType_Tumblr             = 24,//Tumblr（暂未支持）
//    UMSocialPlatformType_Instagram          = 25,//Instagram
//    UMSocialPlatformType_Whatsapp           = 26,//Whatsapp
//    UMSocialPlatformType_Predefine_end      = 999,
//
//    //用户自定义的平台
//    UMSocialPlatformType_UserDefine_Begin = 1000,
//    UMSocialPlatformType_UserDefine_End = 2000,
//};
//---------------------------------------友盟枚举-end------------------------------------------------

//---------------------------------------对应转化-start----------------------------------------------

#define UMSocialPlatformType(UMSocialPlatformType)               \
UMSocialPlatformType(UMSocialPlatformType_Sina)                  \
UMSocialPlatformType(UMSocialPlatformType_WechatSession)         \
UMSocialPlatformType(UMSocialPlatformType_WechatTimeLine)        \
UMSocialPlatformType(UMSocialPlatformType_WechatFavorite)        \
UMSocialPlatformType(UMSocialPlatformType_QQ)                    \
UMSocialPlatformType(UMSocialPlatformType_Qzone)                 \
UMSocialPlatformType(UMSocialPlatformType_TencentWb)             \
UMSocialPlatformType(UMSocialPlatformType_AlipaySession)         \
UMSocialPlatformType(UMSocialPlatformType_YixinSession)          \
UMSocialPlatformType(UMSocialPlatformType_YixinTimeLine)         \
UMSocialPlatformType(UMSocialPlatformType_YixinFavorite)         \
UMSocialPlatformType(UMSocialPlatformType_LaiWangSession)        \
UMSocialPlatformType(UMSocialPlatformType_LaiWangTimeLine)       \
UMSocialPlatformType(UMSocialPlatformType_Sms)                   \
UMSocialPlatformType(UMSocialPlatformType_Email)                 \
UMSocialPlatformType(UMSocialPlatformType_Renren)                \
UMSocialPlatformType(UMSocialPlatformType_Facebook)              \
UMSocialPlatformType(UMSocialPlatformType_Twitter)               \
UMSocialPlatformType(UMSocialPlatformType_Douban)                \
UMSocialPlatformType(UMSocialPlatformType_KakaoTalk)             \
UMSocialPlatformType(UMSocialPlatformType_Pinterest)             \
UMSocialPlatformType(UMSocialPlatformType_Line)                  \
UMSocialPlatformType(UMSocialPlatformType_Linkedin)              \
UMSocialPlatformType(UMSocialPlatformType_Flickr)                \
UMSocialPlatformType(UMSocialPlatformType_Tumblr)                \
UMSocialPlatformType(UMSocialPlatformType_Instagram)             \
UMSocialPlatformType(UMSocialPlatformType_Whatsapp)              \

#define GENERATE_ENUM(ENUM) ENUM,
#define GENERATE_STRING(STRING) #STRING,

typedef enum{
    UMSocialPlatformType_UnKnown = -2,
    UMSocialPlatformType_Predefine_Begin = -1,
    UMSocialPlatformType(GENERATE_ENUM)
    UMSocialPlatformType_Predefine_end = 999,
    UMSocialPlatformType_UserDefine_Begin = 1000,
    UMSocialPlatformType_UserDefine_End = 2000,
}UMSocialPlatformType;

static const char *UMSocialPlatform[] = {
    UMSocialPlatformType(GENERATE_STRING)
};

//---------------------------------------对应转化-end----------------------------------------------


@interface EnumClass : NSObject

@end
