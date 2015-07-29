//
//  DetialMovieView.h
//  MMLee
//
//  Created by 郭梦浩 on 15/5/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailMovieViewDelegate <NSObject>

/**
 *  根据scrollView的偏移量设置navigationBar的透明度
 *
 *  @param contentOffset scrollView的偏移量
 */
- (void)detialmovieViewDidScrollContentOffset:(CGPoint)contentOffset;

/**
 *  分享按钮被点击
 *
 *  @param sender 被点击的按钮
 */
- (void)detialMovieViewShareButtonPress:(UIButton *)sender;

@end

@interface DetialMovieView : UIView

@property (nonatomic, weak) id<DetailMovieViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame MoveName:(NSString *)movieName;

- (void)showDatingImageView;
- (void)loadDetailDataSourceWith:(NSDictionary *)Dic;
@end
