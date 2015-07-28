//
//  MusicInfoViewModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MusicInfoViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import "PublicClass.h"
#import "MusicInfoModel.h"
@implementation MusicInfoViewModel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.MusicSearchPonseObj = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)postSearchMusic:(NSString *)searchText {
    
    NSDictionary *postDic = @{
                              @"s" : searchText,
                              @"type" : @"1",
                              @"limit" : @"5",
                              @"offset" : @"0"
                              };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [manager.requestSerializer setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
    [manager.requestSerializer setValue:@"appver=1.5.0.75771" forHTTPHeaderField:@"Cookie"];
    [manager POST:MusicForm parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *doubi = responseObject;
        id object = [NSJSONSerialization JSONObjectWithData:doubi options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary *soucreDic =(NSDictionary *) object;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < [(NSArray *)(soucreDic[@"result"][@"songs"]) count]; i++) {
            [array addObject:[[MusicInfoModel alloc] initWithDictionary:(NSDictionary *)((NSArray *)(soucreDic[@"result"][@"songs"])[i])]];
        }
        self.MusicSearchPonseObj = array;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
