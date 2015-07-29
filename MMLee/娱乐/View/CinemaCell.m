//
//  CinemaCell.m
//  MMLee
//
//  Created by 郭梦浩 on 15/5/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "CinemaCell.h"
#import "cinemaModel.h"
#import "CinemaFrame.h"

#define NAME_FONT [UIFont systemFontOfSize:18 weight:2]
#define DISTANCE_FONT [UIFont systemFontOfSize:18]
#define ADDRESS_FONT [UIFont systemFontOfSize:15]

@interface CinemaCell ()

@property (strong, nonatomic)  UILabel *cinemaNameLabel;

@property (strong, nonatomic)  UILabel *distanceLabel;

@property (strong, nonatomic)  UILabel *addressLabel;

@property (strong, nonatomic)  UILabel *trafficRoutesLabel;


@end

@implementation CinemaCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cinemaNameLabel = [[UILabel alloc] init];
        _cinemaNameLabel.font = NAME_FONT;
        _cinemaNameLabel.numberOfLines = 0;
        [self addSubview:_cinemaNameLabel];
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = DISTANCE_FONT;
        _distanceLabel.textColor = [UIColor orangeColor];
        [self addSubview:_distanceLabel];
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = ADDRESS_FONT;
        _addressLabel.numberOfLines = 0;
        [self addSubview:_addressLabel];
        _trafficRoutesLabel = [[UILabel alloc] init];
        _trafficRoutesLabel.font = ADDRESS_FONT;
        _trafficRoutesLabel.numberOfLines = 0;
        [self addSubview:_trafficRoutesLabel];
    }
    return self;
}


- (void)setModelF:(CinemaFrame *)modelF {
    
    _modelF = modelF;
    cinemaModel *cinema = _modelF.cinema;
    NSString *cinemaName = cinema.cinemaName;
    _cinemaNameLabel.text = cinemaName;
    _cinemaNameLabel.frame = _modelF.cinemaNameF;
    
    _distanceLabel.text = [NSString stringWithFormat:@"距离：%@", cinema.distance];
    _distanceLabel.frame = _modelF.distanceF;
    
    _addressLabel.text = [NSString stringWithFormat:@"地址：%@", cinema.address];
    _addressLabel.frame = _modelF.addressF;
    
    _trafficRoutesLabel.text = [NSString stringWithFormat:@"公交路线：%@", cinema.trafficRoutes];
    _trafficRoutesLabel.frame = _modelF.trafficRoutesF;
    
}


@end
