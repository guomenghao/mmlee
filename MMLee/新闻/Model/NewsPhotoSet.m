//
//  SXPhotoSet.m
//  MMLee
//
//  Created by 郭梦浩 on 15/2/3.
//  Copyright (c) 2015年. All rights reserved.
//

#import "NewsPhotoSet.h"
#import "NewsPhotosDetail.h"

@implementation NewsPhotoSet

+ (instancetype)photoSetWith:(NSDictionary *)dict
{
    NewsPhotoSet *photoSet = [[NewsPhotoSet alloc]init];
    [photoSet setValuesForKeysWithDictionary:dict];
    
    NSArray *photoArray = photoSet.photos;
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:photoArray.count];
    
    for (NSDictionary *dict in photoArray) {
        NewsPhotosDetail *photoModel = [NewsPhotosDetail photoDetailWithDict:dict];
        [temArray addObject:photoModel];
    }
    photoSet.photos = temArray;
    
    return photoSet;
}

@end
