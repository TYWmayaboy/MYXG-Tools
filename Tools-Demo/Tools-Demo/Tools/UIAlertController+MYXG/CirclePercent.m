//
//  CirclePercent.m
//  SJDApp
//
//  Created by apple on 16/2/10.
//  Copyright © 2016年 agewnetLV. All rights reserved.
//

#import "CirclePercent.h"

@interface CirclePercent()
{
    UILabel *percentLabel;
}

@end

@implementation CirclePercent

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadDefaultSetting];
    }
    
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        
        [self loadDefaultSetting];
    }
    return self;
}
-(void)loadDefaultSetting
{
    _bgcolor = [UIColor lightGrayColor];
    _frcolor = [UIColor greenColor];
    _percent = 0;
}
-(id)initWithFrame:(CGRect)frame Percent :(CGFloat )percent frColor:(UIColor *)frcolor bgColor:(UIColor *)bgcolor
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _percent = percent;
        _bgcolor = bgcolor;
        _frcolor = frcolor;
//        [self setNeedsDisplay];
        
        
        percentLabel = [[UILabel alloc   ]initWithFrame:self.bounds];
        percentLabel.text = [NSString stringWithFormat:@"%.1f%%",_percent];
        percentLabel.textAlignment = NSTextAlignmentCenter;
        percentLabel.font = [UIFont systemFontOfSize:self.bounds.size.width/4];
        [self addSubview:percentLabel];
        
        [self setNeedsLayout];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, _frcolor.CGColor);
    CGContextSetLineWidth(context, 3);
//    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, rect.size.width/2-1, 0, _percent/100.0*M_PI/180, 0);
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, rect.size.width/2-2, -M_PI/2, -1*M_PI/2+_percent/100.0*2*M_PI, 0);
    
    
    
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    CGContextSetStrokeColorWithColor(context, _bgcolor.CGColor);
    CGContextSetLineWidth(context, 3);
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, rect.size.width/2-2,  -1*M_PI/2+_percent/100.0*2*M_PI,3*M_PI/2, 0);
    
    
    CGContextDrawPath(context, kCGPathStroke);

    
}


-(void)setPercent:(CGFloat)percent
{
    _percent = percent;
    percentLabel.text = [NSString stringWithFormat:@"%.1f%%",_percent];
//    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)drawText:(NSString *)str atPoint:(CGPoint)point FontSize:(float)fontSize
{
    [[UIColor blackColor] set];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontSize]};
    [str drawAtPoint:point withAttributes:attributes];
}

-(void)layoutSubviews
{

   
    
    
    
}




@end
