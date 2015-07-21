//
//  CustomCollectionViewCell.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/21.
//  Copyright © 2015年 郭梦浩. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.title = [[UILabel alloc] init];
        self.title.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 5);
        self.title.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
        self.title.font = [UIFont systemFontOfSize:15];
        self.title.textColor = [UIColor grayColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.title];
        
    }
    
    return self;
}
@end
