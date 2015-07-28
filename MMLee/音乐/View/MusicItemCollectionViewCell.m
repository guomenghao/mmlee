//
//  MusicItemCollectionViewCell.m
//  生活应用
//
//  Created by guomenghao on 15/5/18.
//  Copyright (c) 2015年 guomenghao. All rights reserved.
//

#import "MusicItemCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MusicItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.frame = CGRectMake(5, 5, 100, 95);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
        
        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.textColor = [UIColor grayColor];
        self.label.textAlignment= NSTextAlignmentCenter;
        self.label.frame = CGRectMake(5, 105, 120, 50);
        self.label.numberOfLines = 0;
        [self.contentView addSubview:self.label];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowRadius = 1.0;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 0);
        self.layer.shadowOpacity = 0.3;
    }
    return self;
}

- (void)updateMusicItemViewCell:(NSDictionary *)Dic {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:Dic[@"musicListImage"]]];
    [self.label setText:Dic[@"musicListTitle"]];
    
}

@end
