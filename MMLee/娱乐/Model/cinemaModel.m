//
//  cinemaModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "cinemaModel.h"

@implementation cinemaModel
+ (cinemaModel *)modelWithDic:(NSDictionary *)dic {
    
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (NSString *key in dic) {
            if (![key isEqualToString:@"id"]) {
                [tempDic setValue:dic[key] forKey:key];
            }
        }
        [self setValuesForKeysWithDictionary:tempDic];
    }
    return self;
}
@end
