//
//  MovieInfoModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/28.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfoModel : NSObject
@property (nonatomic, strong, readonly) NSString *poster;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *genres;
@property (nonatomic, strong, readonly) NSString *rating;
@property (nonatomic, strong, readonly) NSString *runtime;
@property (nonatomic, strong, readonly) NSString *plot_simple;
@property (nonatomic, strong, readonly) NSString *release_date;
@property (nonatomic, strong, readonly) NSString *movieid;
@property (nonatomic, strong, readonly) NSString *actors;
@property (nonatomic, strong, readonly) NSString *also_known_as;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, strong, readonly) NSString *directors;
@property (nonatomic, strong, readonly) NSString *film_locations;
@property (nonatomic, strong, readonly) NSString *language;
@property (nonatomic, strong, readonly) NSString *rated;
@property (nonatomic, strong, readonly) NSString *rating_count;
@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, strong, readonly) NSString *writers;
@property (nonatomic, strong, readonly) NSString *year;
@end
