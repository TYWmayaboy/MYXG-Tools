//
//  ChangePageView.m
//  Tools-Demo
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import "ChangePageView.h"
#import "UIImage+SJD.h"
#import "Masonry.h"

#define btnW 30
#define btnH 25
#define btnMargin 10
#define btnSepW 30//两边宽
#define row 5 //最少row

#define changeScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define changeScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface ChangePageView()

/**
 *  是否有...(更多)
 */
@property(nonatomic,assign)BOOL isMore;

@property(nonatomic,assign)NSInteger currentIndex;

@end

@implementation ChangePageView

-(void)setAllCount:(int)allCount
{
    _allCount = allCount;
    
    for (id sub in self.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            [sub removeFromSuperview];
        }
    }
    
    self.isMore = NO;
    int ERow = 0;
    ERow = (int)allCount+row-1;
    if (allCount == 0) {
        ERow++;
    }
    
    CGFloat firstX = (changeScreenWidth-2*btnSepW-(ERow-2)*btnW-(ERow-1)*btnMargin)/2;
    if (firstX <= 0) {
        self.isMore = YES;
        ERow = (changeScreenWidth-2*btnSepW-2*btnW-2*btnMargin)/btnW+1;
        firstX = (changeScreenWidth-2*btnSepW-(ERow-2)*btnW-(ERow-1)*btnMargin)/2;
    }
    UIButton *lastBtn;
    for (int i = 0; i < ERow; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor blueColor]] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        if (i == 0) {
            btn.tag = -1;
            [btn setTitle:@"<<" forState:UIControlStateNormal];
        }else if (i == 1){
            btn.tag = -2;
            [btn setTitle:@"<" forState:UIControlStateNormal];
        }else if (i == ERow-1){
            btn.tag = -4;
            [btn setTitle:@">>" forState:UIControlStateNormal];
        }else if (i == ERow -2){
            btn.tag = -3;
            [btn setTitle:@">" forState:UIControlStateNormal];
        }else{
            btn.tag = i-2;
            [btn setTitle:[NSString stringWithFormat:@"%i",i-1] forState:UIControlStateNormal];
        }
        if (self.isMore) {
            if (i == ERow-3) {
                btn.tag = -5;
                [btn setTitle:@"..." forState:UIControlStateNormal];
            }
        }
        if (i == self.currentPage+2) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0 || i == ERow-1) {
                make.width.mas_equalTo(btnSepW);
            }else{
                make.width.mas_equalTo(btnW);
            }
            make.height.mas_equalTo(btnH);
            make.top.equalTo(self.mas_top).offset(btnMargin);
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(btnMargin);
            }else{
                make.left.equalTo(self.mas_left).offset(firstX);
            }
        }];
        
        lastBtn = btn;
    }
    
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    _currentIndex = _currentPage;
}

-(void)clickBtn:(UIButton *)sender
{
    //    SDLog(@"sender：%ld",sender.tag);
    if (_allCount <= 1) {
        return;
    }
    if (sender.tag != -5) {
        for (id sub in self.subviews) {
            if ([sub isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)sub;
                btn.selected = NO;
            }
        }
    }
    
    if (sender.tag >= 0) {//普通按钮
        self.currentIndex = sender.tag;
        sender.selected = YES;
    }else if(sender.tag == -1){//首部
        [self changeBtnWithIndex:0];
    }else if (sender.tag == -2){//上一个
        NSInteger num = _currentIndex;
        num--;
        if (num <= 0) {
            num = 0;
        }
        [self changeBtnWithIndex:num];
        
    }else if (sender.tag == -3){//下一个
        NSInteger num = _currentIndex;
        num++;
        if (num >= _allCount-1) {
            num = _allCount-1;
        }
        [self changeBtnWithIndex:num];
        
    }else if (sender.tag == -4){//尾部
        [self changeBtnWithIndex:_allCount-1];
    }else if (sender.tag == -5){//更多
        
    }
    
}

-(void)setBtnSelIndex:(NSInteger)index subIndex:(NSInteger)subIndex
{
    //    SDLog(@"index:%ld,subIndex:%ld",index,subIndex);
    UIButton *btn = self.subviews[subIndex];
    btn.tag = index;
    btn.selected = YES;
    [btn setTitle:[NSString stringWithFormat:@"%ld",index+1] forState:UIControlStateNormal];
    self.currentIndex = btn.tag;
}

-(void)changeBtnWithIndex:(NSInteger)index
{
    int showNum = (int)self.subviews.count-4;//需要改变title的btn数量
    
    //    SDLog(@"index:%ld,%d",index,showNum);
    NSInteger currentSubIndex = index+2;
    BOOL isNext = YES;
    BOOL isLast = YES;
    //现在button
    if (index+3 >= self.subviews.count-2) {
        currentSubIndex = self.subviews.count-3;
        isNext = NO;
    }else if (index+3 <= 3){
        currentSubIndex = 2;
        isLast = NO;
    }
    [self setBtnSelIndex:index subIndex:currentSubIndex];
    
    //上一个button
    if (isLast) {
        if (currentSubIndex-1 != 1) {
            UIButton *lastBtn = self.subviews[currentSubIndex-1];
            lastBtn.tag = index-1;
            [lastBtn setTitle:[NSString stringWithFormat:@"%ld",index] forState:UIControlStateNormal];
            
        }
    }
    
    //下一个button
    if (isNext) {
        UIButton *nextBtn = self.subviews[currentSubIndex+1];
        nextBtn.tag = index+1;
        [nextBtn setTitle:[NSString stringWithFormat:@"%ld",index+2] forState:UIControlStateNormal];
        
    }
    
    //更多button
    if (self.isMore) {
        //        SDLog(@"%d,%ld",showNum,index);
        if (index >= showNum) {
            UIButton *moreBtn = self.subviews[2];
            moreBtn.tag = -5;
            [moreBtn setTitle:@"..." forState:UIControlStateNormal];
        }
        if (currentSubIndex != self.subviews.count-3) {
            UIButton *moreBtn = self.subviews[self.subviews.count-3];
            moreBtn.tag = -5;
            [moreBtn setTitle:@"..." forState:UIControlStateNormal];
        }
    }
}

-(void)setCurrentIndex:(NSInteger)currentIndex
{
    //    SDLog(@"%ld,%ld",_currentIndex,currentIndex);
    if (_currentIndex != currentIndex) {
        _currentIndex = currentIndex;
        if ([self.delegate respondsToSelector:@selector(passCurrentPage:)]) {
            [self.delegate passCurrentPage:_currentIndex];
        }
    }
}
@end
