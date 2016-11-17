//
//  CustomAlertView.m
//  SouDian
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 agewnetLV. All rights reserved.
//

#import "CustomAlertView.h"

@interface CustomAlertView()
{
    BOOL _isShow;
}
@property (nonatomic, retain) NSString       *cancelButtonTitle;
@property (nonatomic, retain) NSMutableArray *otherButtonTitles;

@end

@implementation CustomAlertView

static const CGFloat mWidth  = 290;
static const CGFloat mHeight = 180;
static const CGFloat mMaxHeight    = 250;
static const CGFloat mBtnHeight    = 30;
static const CGFloat mBtnWidth     = 110;
static const CGFloat mHeaderHeight = 40;

+ (CustomAlertView *)defaultAlert
{
    static CustomAlertView *shareCenter = nil;
    if (!shareCenter)
    {
        shareCenter = [[CustomAlertView alloc] init];
    }
    return shareCenter;
}

- (NSMutableArray *)customerViewsToBeAdd
{
    if (_customerViewsToBeAdd == nil)
    {
        _customerViewsToBeAdd = [[NSMutableArray alloc] init];
    }
    
    return _customerViewsToBeAdd;
}
- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    if (self)
    {
        _isShow = NO;
    }
    return self;
}

- (id)initWithTitle:(NSString*)title message:(NSString*)message delegate:(id)del cancelButtonTitle:(NSString*)cancelBtnTitle otherButtonTitles:(NSString*)otherBtnTitles, ...
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    if (self)
    {
        self.delegate = del;
        self.cancelButtonTitle = cancelBtnTitle;
        self.isNeedCloseBtn = NO;
        
        if (!_otherButtonTitles)
        {
            va_list argList;
            if (otherBtnTitles)
            {
                self.otherButtonTitles = [NSMutableArray array];
                [self.otherButtonTitles addObject:otherBtnTitles];
                NSLog(@"多少个按Ｊ%ld",self.otherButtonTitles.count);
            }
            va_start(argList, otherBtnTitles);
            id arg;
            while ((arg = va_arg(argList, id)))
            {
                [self.otherButtonTitles addObject:arg];
            }
        }
        self.title = title;
        self.message = message;
        
    }
    return self;
}

-(void)initTitle:(NSString*)title message:(NSString*)message delegate:(id)del cancelButtonTitle:(NSString*)cancelBtnTitle otherButtonTitles:(NSString*)otherBtnTitles, ...
{
    if (self)
    {
        self.delegate = del;
        self.cancelButtonTitle = cancelBtnTitle;
        self.isNeedCloseBtn = NO;
        
        if (!_otherButtonTitles)
        {
            va_list argList;
            if (otherBtnTitles)
            {
                self.otherButtonTitles = [NSMutableArray array];
                [self.otherButtonTitles addObject:otherBtnTitles];
            }
            va_start(argList, otherBtnTitles);
            id arg;
            while ((arg = va_arg(argList, id)))
            {
                [self.otherButtonTitles addObject:arg];
            }
        }
        self.title = title;
        self.message = message;
    }
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.frame];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setAlpha:0.4];
    [self addSubview:bgView];
//    [bgView release];
    
    if (!_backView)
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mWidth, mHeight)];
        _backView.opaque = NO;
        _backView.backgroundColor     = [UIColor whiteColor];
        _backView.layer.shadowOffset  = CGSizeMake(1, 1);
        _backView.layer.shadowRadius  = 2.0;
        _backView.layer.shadowColor   = [UIColor grayColor].CGColor;
        _backView.layer.shadowOpacity = 0.8;
        [_backView.layer setMasksToBounds:NO];
    }
    
    // - 设置头部显示区域
    // - 设置标题背景
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mWidth, mHeaderHeight)];
    titleView.backgroundColor = RGBA_COLOR(36, 193, 64, 1);
    
    CGSize titleSize = CGSizeZero;
    if (self.title && [self.title length] > 0)
    {
        titleSize = [self.title sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0f]];
    }
    if (titleSize.width > 0)
    {
        // - 标题图片
        CGFloat startX = (titleView.frame.size.width - 40 - titleSize.width) / 2;
        UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xxxxx.png"]];
        titleImage.frame = CGRectMake(startX, (titleView.frame.size.height - 30) / 2, 30, 30);
        self.titleIcon = titleImage;
        
        [titleView addSubview:titleImage];
//        [titleImage release];
        startX += 40;
        
        // - 标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX, (titleView.frame.size.height - 20) / 2, titleSize.width, 20)];
        
        //- 标题太长的话需要处理
        if (titleLabel.frame.size.width > 250)
        {
            titleLabel.frame = CGRectMake(50, (titleView.frame.size.height - 20) / 2, mWidth - 60, 20);
            
            titleImage.frame = CGRectMake(5, (titleView.frame.size.height - 30) / 2, 30, 30);
            
        }
        
        titleLabel.text = self.title;
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel = titleLabel;
        
        [titleView addSubview:titleLabel];
//        [titleLabel release];
    }else
    {
        // - 标题图片
        UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xxxxx.png"]];
        titleImage.frame = CGRectMake((titleView.frame.size.width - 30) / 2, (titleView.frame.size.height - 30) / 2, 30, 30);
        [titleView addSubview:titleImage];
//        [titleImage release];
    }
    if (self.isNeedCloseBtn)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(mWidth-mHeaderHeight, 0, mHeaderHeight, mHeaderHeight)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setImage:[UIImage imageNamed:@"btn_close_alertview.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
//        [btn release];
    }
    
    [_backView addSubview:titleView];
    self.titleBackgroundView = titleView;
//    [titleView release];
    
    // - 设置消息显示区域
    UIScrollView *msgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mHeaderHeight, mWidth, (mHeight-mHeaderHeight * 2))];
    
    // - 设置背景颜色
    msgView.backgroundColor = [UIColor whiteColor];
    
    // - 内容
    CGSize messageSize = CGSizeZero;
    if (self.message && [self.message length]>0)
    {
        messageSize = [self.message sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(mWidth-20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        if (messageSize.width > 0)
        {
            UILabel *msgLabel = [[UILabel alloc] init];
            msgLabel.font = [UIFont systemFontOfSize:16.0f];
            msgLabel.text = self.message;
            msgLabel.numberOfLines   = 0;
            msgLabel.textAlignment   = NSTextAlignmentCenter;
            msgLabel.backgroundColor = [UIColor clearColor];
            msgLabel.frame = CGRectMake(10, ((mHeight - mHeaderHeight * 2) - messageSize.height) / 2, mWidth-20, messageSize.height + 5);
            if(messageSize.height > mMaxHeight)
            {
                msgView.frame = CGRectMake(msgView.frame.origin.x, msgView.frame.origin.y, msgView.frame.size.width, mMaxHeight + 25);
                _backView.frame = CGRectMake(0, 0, mWidth, mHeaderHeight * 2 + msgView.frame.size.height);
                msgLabel.textAlignment = NSTextAlignmentLeft;
                msgLabel.frame = CGRectMake(10, 10, mWidth - 20, messageSize.height);
                msgView.contentSize = CGSizeMake(msgView.frame.size.width, msgLabel.frame.size.height + 20);
            }
            else if (messageSize.height > (mHeight-mHeaderHeight * 2) - 10)
            {
                msgView.frame = CGRectMake(msgView.frame.origin.x, msgView.frame.origin.y, msgView.frame.size.width, messageSize.height + 25);
                _backView.frame = CGRectMake(0, 0, mWidth, mHeaderHeight * 2 + msgView.frame.size.height);
                msgLabel.frame = CGRectMake(10, 10, mWidth - 20, messageSize.height + 5);
            }
            [msgView addSubview:msgLabel];
//            [msgLabel release];
            [_backView addSubview:msgView];
        }
    }else{
        if (self.customerViewsToBeAdd && [self.customerViewsToBeAdd count] > 0)
        {
            CGFloat startY = 0;
            for (UIView *subView in self.customerViewsToBeAdd)
            {
                CGRect rect = subView.frame;
                rect.origin.y = startY;
                subView.frame = rect;
                [msgView addSubview:subView];
                startY += rect.size.height;
            }
            msgView.frame = CGRectMake(0, mHeaderHeight, mWidth, startY);
        }
        [_backView addSubview:msgView];
        _backView.frame = CGRectMake(0, 0, mWidth, msgView.frame.size.height + mHeaderHeight * 2 +20);
    }
//    [msgView release];
    
    // - 设置按钮显示区域
    if (_otherButtonTitles != nil || _cancelButtonTitle != nil)
    {
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, _backView.frame.size.height-mHeaderHeight, mWidth, mHeaderHeight)];
        
        // - 如果只显示一个按钮,需要计算按钮的显示大小
        if (_otherButtonTitles == nil || _cancelButtonTitle == nil)
        {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((_backView.frame.size.width-mBtnWidth) /  2, 0, mBtnWidth, mBtnHeight)];
            btn.backgroundColor = RGBA_COLOR(36, 193, 64, 1);
            btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
            btn.titleLabel.textColor = [UIColor whiteColor];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            if (_otherButtonTitles == nil && _cancelButtonTitle != nil)
            {
                [btn setTitle:_cancelButtonTitle forState:UIControlStateNormal];
            } else
            {
                [btn setTitle:[_otherButtonTitles objectAtIndex:0] forState:UIControlStateNormal];
            }
            btn.tag = 0;
            btn.layer.cornerRadius = 5;
            [btnView addSubview:btn];
//            [btn release];
        }
        else if(_otherButtonTitles && [_otherButtonTitles count] == 1)
        {
            // - 显示两个按钮
            // - 设置确定按钮的相关属性
            CGFloat startX = (_backView.frame.size.width-mBtnWidth*2-20)/2;
            UIButton *otherBtn = [[UIButton alloc]initWithFrame:CGRectMake(startX, 0, mBtnWidth, mBtnHeight)];
            otherBtn.backgroundColor = RGBA_COLOR(36, 193, 64, 1);
            otherBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
            otherBtn.titleLabel.textColor = [UIColor whiteColor];
            [otherBtn setTitle:[_otherButtonTitles objectAtIndex:0] forState:UIControlStateNormal];
            otherBtn.layer.cornerRadius = 5;
            [otherBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            otherBtn.tag = 0;
            [btnView addSubview:otherBtn];
//            [otherBtn release];
            startX += mBtnWidth+20;
            
            // - 设置取消按钮的相关属性
            UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(startX, 0, mBtnWidth, mBtnHeight)];
            cancelBtn.backgroundColor = RGBA_COLOR(36, 193, 64, 1);
            cancelBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0f];
            cancelBtn.titleLabel.textColor = [UIColor whiteColor];
            [cancelBtn setTitle:_cancelButtonTitle forState:UIControlStateNormal];
            cancelBtn.layer.cornerRadius = 5;
            [cancelBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            cancelBtn.tag = 1;
            [btnView addSubview:cancelBtn];
//            [cancelBtn release];
        }
        [_backView addSubview: btnView];
//        [btnView release];
    }
    else
    {
        CGRect rc = _backView.frame;
        rc.size.height -= mHeaderHeight;
        _backView.frame = rc;
    }
    
    UIControl *touchView = [[UIControl alloc] initWithFrame:self.frame];
    [touchView addTarget:self action:@selector(touchViewClickDown) forControlEvents:UIControlEventTouchDown];
    touchView.frame = self.frame;
    [self addSubview:touchView];
//    [touchView release];
    _backView.center = self.center;
    
    
    [self addSubview:_backView];
    
    if (!_isShow)
        [CustomAlertView exChangeOut:_backView dur:0.5];
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(willPresentCustomAlertView:)])
        {
            [self.delegate willPresentCustomAlertView:self];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kBCAlertViewPresentNotify object:nil userInfo:nil];
    }
}

- (void)touchViewClickDown
{
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(hideCurrentKeyBoard)])
        {
            [self.delegate hideCurrentKeyBoard];
        }
    }
}

// - 在消息区域设置自定义控件
- (void)addCustomerSubview:(UIView *)view
{
    [self.customerViewsToBeAdd addObject:view];
}

- (void)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    _isShow = NO;
    if (btn)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
        {
            [self.delegate alertView:self clickedButtonAtIndex:btn.tag];
        }
        [self removeFromSuperview];
    }
}

- (void)closeBtnClicked:(id)sender
{
    _isShow = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewClosed:)])
    {
        [self.delegate alertViewClosed:self];
    }
    [self removeFromSuperview];
}


- (void)show
{
    [self layoutSubviews];
    if (!_isShow)
        [[[UIApplication sharedApplication].delegate window]  addSubview:self];
    _isShow = YES;
}

- (void)dealloc
{
//    [_backView release];
//    [_customerViewsToBeAdd release];
    self.titleLabel = nil;
    self.titleBackgroundView = nil;
    self.titleIcon = nil;
    
//    [super dealloc];
}

// - alertview弹出动画
+ (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
}


@end
