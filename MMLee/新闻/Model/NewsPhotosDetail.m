//
//  SXPhotosDetail.m
//  MMLee
//
//  Created by 郭梦浩 on 15/2/3.
//  Copyright (c) 2015年. All rights reserved.
//

#import "NewsPhotosDetail.h"

@implementation NewsPhotosDetail

+ (instancetype)photoDetailWithDict:(NSDictionary *)dict
{
    NewsPhotosDetail *photoDetail = [[NewsPhotosDetail alloc]init];
    [photoDetail setValuesForKeysWithDictionary:dict];
    
    return photoDetail;
}

@end
