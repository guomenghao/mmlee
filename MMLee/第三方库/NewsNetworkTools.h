//
//  SXNetworkTools.h
//  MMLee
//
//  Created by 郭梦浩 on 15-1-22.
//  Copyright (c) 2015年. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NewsNetworkTools : AFHTTPSessionManager

+ (instancetype)sharedNetworkTools;

@end
