//
//  cinemaModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cinemaModel : NSObject
@property (nonatomic, strong, readonly) NSString *cityName;
@property (nonatomic, strong, readonly) NSString *cinemaName;
@property (nonatomic, strong, readonly) NSString *address;
@property (nonatomic, strong, readonly) NSString *telephone;
@property (nonatomic, strong, readonly) NSString *trafficRoutes;
@property (nonatomic, strong, readonly) NSString *distance;
@property (nonatomic, strong, readonly) NSString *latitude;
@property (nonatomic, strong, readonly) NSString *longitude;

+ (cinemaModel *)modelWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
