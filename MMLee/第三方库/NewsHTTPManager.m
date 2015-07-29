//
//  SXHTTPManager.m
//  MMLee
//
//  Created by 郭梦浩 on 15-1-24.
//  Copyright (c) 2015年. All rights reserved.
//

#import "NewsHTTPManager.h"

@implementation NewsHTTPManager

+ (instancetype)manager
{
    NewsHTTPManager *mgr = [super manager];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    
    [mgrSet addObject:@"text/html"];
    
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    return mgr;
}

@end
