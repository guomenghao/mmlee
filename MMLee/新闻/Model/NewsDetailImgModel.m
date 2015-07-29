//
//  SXDetailImgModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15-1-24.
//  Copyright (c) 2015年. All rights reserved.
//

#import "NewsDetailImgModel.h"

@implementation NewsDetailImgModel

/** 便利构造器方法 */
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    NewsDetailImgModel *imgModel = [[self alloc]init];
    imgModel.ref = dict[@"ref"];
    imgModel.pixel = dict[@"pixel"];
    imgModel.src = dict[@"src"];
    
    return imgModel;
}

@end
