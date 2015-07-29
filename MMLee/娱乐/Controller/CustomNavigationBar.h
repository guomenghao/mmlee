//
//  CustomNavigationBar.h
//  MMLee
//
//  Created by 郭梦浩 on 15/5/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UIView

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat backgroundAlpha;
@property (nonatomic, strong) UIButton *leftBarButton;
@property (nonatomic, strong) UIButton *rightBarButton;
@property (nonatomic, strong) NSString *title;


@end
