//
//  ConnectingCheck.m
//  MMLee
//
//  Created by 郭梦浩 on 15/5/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "ConnectingCheck.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation ConnectingCheck

+ (BOOL)isConnectionAvailable {
    
    BOOL isConneting = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch (reach.currentReachabilityStatus) {
        case NotReachable:
            isConneting = NO;
            break;
            
        default:
            isConneting = YES;
            break;
    }
    
    if (!isConneting) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"网络不给力，请查看连接状态" preferredStyle:UIAlertControllerStyleAlert];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window.rootViewController presentViewController:alertC animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [delegate.window.rootViewController dismissViewControllerAnimated:alertC completion:nil];
            });
        }];
    }
    return isConneting;
}

@end
