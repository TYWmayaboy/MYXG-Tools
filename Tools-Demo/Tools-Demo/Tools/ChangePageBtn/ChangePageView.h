//
//  ChangePageView.h
//  Tools-Demo
//
//  Created by apple on 2016/11/16.
//  Copyright © 2016年 tyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changePageViewDelegate <NSObject>

@optional
-(void)passCurrentPage:(NSInteger)currentIndex;

@end

@interface ChangePageView : UIView

@property(nonatomic,strong)id<changePageViewDelegate> delegate;
//@property(nonatomic,strong)NSArray *allArr;
/**
 *  总数
 */
@property(nonatomic,assign)int allCount;
/**
 *  当前选中哪个
 */
@property(nonatomic,assign)NSInteger currentPage;

@end
