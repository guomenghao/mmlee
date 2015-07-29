//
//  MovieInfoModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/28.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MovieInfoModel.h"

@implementation MovieInfoModel
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
