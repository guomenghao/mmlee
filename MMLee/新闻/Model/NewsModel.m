//
//  SXNewsModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15-1-22.
//  Copyright (c) 2015年. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    NewsModel *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

@end
