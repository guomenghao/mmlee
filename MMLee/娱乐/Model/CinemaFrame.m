//
//  CinemaFrame.m
//  MMLee
//
//  Created by 郭梦浩 on 15/5/25.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "CinemaFrame.h"
#import "cinemaModel.h"

#define NAME_FONT [UIFont systemFontOfSize:18 weight:2]
#define DISTANCE_FONT [UIFont systemFontOfSize:18]
#define ADDRESS_FONT [UIFont systemFontOfSize:15]


@interface CinemaFrame ()

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

@end

@implementation CinemaFrame

- (void)setCinema:(cinemaModel *)cinema {
    
    _cinema = cinema;
    CGFloat margin = 10;
    CGFloat nameX = margin;
    CGFloat nameY = margin;
    CGSize nameSize = [self sizeWithText:_cinema.cinemaName font:NAME_FONT maxSize:CGSizeMake(235, MAXFLOAT)];
    _cinemaNameF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    CGFloat distanceX = CGRectGetMaxX(_cinemaNameF) + 5;
    CGSize distanceSize = [self sizeWithText:[NSString stringWithFormat:@"距离：%@", cinema.distance] font: DISTANCE_FONT maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat distanceY = CGRectGetMinY(_cinemaNameF) + (nameSize.height - distanceSize.height) / 2;
    _distanceF = CGRectMake(distanceX, distanceY, distanceSize.width, distanceSize.height);
    
    CGFloat addressX = margin;
    CGFloat addressY = CGRectGetMaxY(_cinemaNameF) + margin;
    CGSize addressSize = [self sizeWithText:[NSString stringWithFormat:@"地址：%@", cinema.address] font:ADDRESS_FONT maxSize:CGSizeMake(355, MAXFLOAT)];
    _addressF = CGRectMake(addressX, addressY, addressSize.width, addressSize.height);
    
    CGFloat trafficRoutesX = margin;
    CGFloat trafficRoutesY = CGRectGetMaxY(_addressF) + margin;
    CGSize trafficRoutesSize = [self sizeWithText:[NSString stringWithFormat:@"公交路线：%@", cinema.trafficRoutes] font:ADDRESS_FONT maxSize:CGSizeMake(355, MAXFLOAT)];
    _trafficRoutesF = CGRectMake(trafficRoutesX, trafficRoutesY, trafficRoutesSize.width, trafficRoutesSize.height);
    
    _cellHeight = CGRectGetMaxY(_trafficRoutesF) + margin;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
