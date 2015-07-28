//
//  InfoTableViewCell.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/22.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateCellInfo:(NSDictionary *)Dic {
    
    [self.imageView setImage:[UIImage imageNamed:Dic[@"image"]]];
    [self.title setText:Dic[@"title"]];
    [self.info setText:Dic[@"info"]];
    [self.time setText:Dic[@"time"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
