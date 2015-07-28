//
//  PersonCollectionReusableView.m
//  亲密互动
//
//  Created by 郭梦浩 on 15/5/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MusicCollectionReusableView.h"

@implementation MusicCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        self.label.textColor = [UIColor orangeColor];
        self.label.font = [UIFont systemFontOfSize:18];
        self.label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.label];
        
    }
    
    return self;
}

@end
