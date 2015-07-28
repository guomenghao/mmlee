//
//  RatingView.m
//  一起看电影
//
//  Created by 苏刁 on 15/5/23.
//  Copyright (c) 2015年 苏刁. All rights reserved.
//

#import "RatingView.h"

@interface RatingView () {

    UILabel *_leftNumber;
    UILabel *_rightNumber;
}


@end

@implementation RatingView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        _leftNumber = ({
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds))];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15 weight:2];
            label;
        
        });
        [self addSubview:_leftNumber];
        
        _rightNumber = ({
        
         UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds), 0, CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds))];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:10 weight:1];
            label;

        });
        [self addSubview:_rightNumber];
    }
    return self;
}

- (void)setScore:(NSString *)score {
    
    _score = score;
    NSMutableArray *array = [NSMutableArray array];
    if ([_score containsString:@"."]) {
        array = [[_score componentsSeparatedByString:@"."] mutableCopy];
        _leftNumber.text = [NSString stringWithFormat:@"%@.", array[0]];
        _leftNumber.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds));
        _rightNumber.text = [NSString stringWithFormat:@"%@", array[1]];
        _rightNumber.frame = CGRectMake(CGRectGetMidX(self.bounds) + 3, 5, CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds));
        _rightNumber.hidden = NO;
    } else {
        
        [array addObject:_score];
        _leftNumber.frame = self.bounds;
        _leftNumber.text = [NSString stringWithFormat:@"%@", array[0]];
        _rightNumber.hidden = YES;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
