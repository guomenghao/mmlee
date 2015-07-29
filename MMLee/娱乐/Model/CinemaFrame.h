//
//  CinemaFrame.h
//  MMLee
//
//  Created by 郭梦浩 on 15/5/25.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class cinemaModel;
@interface CinemaFrame : NSObject

@property (nonatomic, assign, readonly) CGRect cinemaNameF;
@property (nonatomic, assign, readonly) CGRect addressF;
@property (nonatomic, assign, readonly) CGRect trafficRoutesF;
@property (nonatomic, assign, readonly) CGRect distanceF;
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, strong) cinemaModel *cinema;

@end
