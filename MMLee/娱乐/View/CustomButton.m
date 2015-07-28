//
//  CustomButton.m
//  一起看电影
//
//  Created by 苏刁 on 15/5/23.
//  Copyright (c) 2015年 苏刁. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;



@end

@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CustomButton" owner:nil options:nil] lastObject];
        self.frame = frame;

    }
    return self;
}

- (void)setTitleString:(NSString *)titleString {
    
    _titleString = titleString;
    self.title.text = _titleString;
}

- (void)setSubtitleString:(NSString *)subtitleString {
    
    _subtitleString = subtitleString;
    self.subtitle.text = _subtitleString;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


@end
