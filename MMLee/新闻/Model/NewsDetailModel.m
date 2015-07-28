//
//  SXDetailModel.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-24.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "NewsDetailModel.h"
#import "NewsDetailImgModel.h"
@implementation NewsDetailModel

/** 便利构造器 */
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    NewsDetailModel *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        NewsDetailImgModel *imgModel = [NewsDetailImgModel detailImgWithDict:dict];
        [temArray addObject:imgModel];
    }
    detail.img = temArray;
    
    
    return detail;
}

@end
