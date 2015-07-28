//
//  MainPageView.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@protocol MainPageViewDelegate <NSObject>

/**
 *  详细信息按钮被点击
 *
 *  @param sender    被点击的按钮
 *  @param movieName 当前页的电影名
 */
- (void)mainPageViewDetialButtonPress:(UIButton *)sender movieName:(NSString *)movieName;

/**
 *  根据scrollView的偏移量设置navigationBar的透明度
 *
 *  @param contentOffset scrollView的偏移量
 */
- (void)mainPageViewWholePageDidScrollToContentOffset:(CGPoint)contentOffset;

/**
 *  附近电影院按钮被点击
 *
 *  @param cinemas 附近的电影院
 */
- (void)mainPageViewCinameButtonPressWithCinemas:(NSArray *)cinemas;

@end

@interface MainPageView : UIView {
    
    
}

@property (nonatomic, weak) id<MainPageViewDelegate>  delegate;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UILabel *movieName;

@end

