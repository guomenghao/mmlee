//
//  CustomNavigationBar.m
//  MMLee
//
//  Created by 郭梦浩 on 15/5/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "CustomNavigationBar.h"

@interface CustomNavigationBar () {
    
    UIView *_backgroundView;
    UILabel *_titleLabel;
}


@end

@implementation CustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_backgroundView];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.bounds = CGRectMake(0, 0, 200, 30);
        _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)+ 5);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:2];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        _leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMidY(self.bounds) - 10, 70, 30)];
        _leftBarButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_leftBarButton];
        
        _rightBarButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bounds) - 60, CGRectGetMidY(self.bounds) - 10, 50, 30)];
        _rightBarButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_rightBarButton];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    _titleLabel.text = _title;
}


- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    
    _backgroundAlpha = backgroundAlpha;
    if (_backgroundAlpha >= 0 && _backgroundAlpha <= 1) {

        _backgroundView.alpha = _backgroundAlpha;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    _backgroundColor = backgroundColor;
    _backgroundView.backgroundColor = _backgroundColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
