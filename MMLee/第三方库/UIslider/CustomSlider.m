//
//  CustomSlider.m
//  亲密互动
//
//  Created by 郭梦浩 on 15/5/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "CustomSlider.h"

@interface CustomSlider () {
    
    
    
    CGRect _currentFrame;
}
- (void)initilazeApearance;
@end
@implementation CustomSlider

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _currentFrame = frame;
        [self initilazeApearance];
        
    }
    
    return self;
}

- (void)initilazeApearance {
    _progressView = [[LDProgressView alloc] initWithFrame:CGRectMake(0, 0, _currentFrame.size.width, _currentFrame.size.height)];
    _progressView.progress = 0.0;
    _progressView.color = [UIColor orangeColor];
    _progressView.flat = @YES;
    _progressView.showBackgroundInnerShadow = @NO;
    _progressView.animate = @YES;
    _progressView.userInteractionEnabled = YES;
    [self addSubview:_progressView];
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, _currentFrame.size.width, _currentFrame.size.height)];
    _slider.backgroundColor = [UIColor clearColor];
    _slider.minimumValue = 0;
    _slider.maximumValue = 1;
    _slider.value = 0;
    [_slider setMinimumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    [self addSubview:_slider];
    
    
}

@end
