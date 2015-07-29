//
//  CinemasView.h
//  MMLee
//
//  Created by 郭梦浩 on 15/5/25.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cinemasViewDelegate <NSObject>

/**
 *  根据scrollView的偏移量设置navigationBar的透明度
 *
 *  @param contentOffset scrollView的偏移量
 */
- (void)cinemasViewDidScorllToContentOffset:(CGPoint)contentOffset;

@end

@interface CinemasView : UIView

@property (nonatomic, assign) id<cinemasViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;
@end
