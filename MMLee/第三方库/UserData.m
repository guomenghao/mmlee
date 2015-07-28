//
//  UserData.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "UserData.h"
static UserData *userData = nil;
@implementation UserData
+ (UserData *)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userData = [[UserData alloc] init];
        
    });//整个程序周期只执行一次，保护线程
    return userData;
}
@end
