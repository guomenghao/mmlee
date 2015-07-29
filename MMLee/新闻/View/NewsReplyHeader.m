//
//  SXReplyHeader.m
//  MMLee
//
//  Created by 郭梦浩 on 15/2/8.
//  Copyright (c) 2015年. All rights reserved.
//

#import "NewsReplyHeader.h"

@implementation NewsReplyHeader

/** 类方法快速返回热门跟帖的view */
+ (instancetype)replyViewFirst
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"NewsReplyHeader" owner:nil options:nil];
    return [array firstObject];
}

/** 类方法快速返回最新跟帖的view */
+ (instancetype)replyViewLast
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"NewsReplyHeader" owner:nil options:nil];
    return [array lastObject];
}

@end
