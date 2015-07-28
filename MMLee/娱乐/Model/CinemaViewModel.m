//
//  CinemaViewModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "CinemaViewModel.h"

@implementation CinemaViewModel
- (void)postMovieInfo:(CLLocationCoordinate2D)coordinate didUpdateToLocation:(CLLocation *)newLocation {
    coordinate = newLocation.coordinate;
    
    NSDictionary *parameter = @{@"lat" : [NSString stringWithFormat:@"%f", coordinate.latitude],
                                @"lon" : [NSString stringWithFormat:@"%f", coordinate.longitude],
                                @"radius" : @"2500"};
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:@"http://v.juhe.cn/movie/cinemas.local" APIID:@"42" Parameters:parameter Method:@"GET" Success:^(id responseObject) {
        
        self.cinemaResponseObject = responseObject;
        
    } Failure:^(NSError *error) {
        
    }];
}
@end
