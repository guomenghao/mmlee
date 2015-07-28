//
//  CinemaViewModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHAPISDK.h"
#import <MapKit/MapKit.h>
@interface CinemaViewModel : NSObject
@property (nonatomic,strong)id cinemaResponseObject;
- (void)postMovieInfo:(CLLocationCoordinate2D)coordinate didUpdateToLocation:(CLLocation *)newLocation;
@end
