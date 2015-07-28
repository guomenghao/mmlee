//
//  MusicViewModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/23.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MusicViewModel.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "PublicClass.h"
#import "MusicModel.h"
@interface MusicViewModel ()

@end
@implementation MusicViewModel


#pragma mark - 界面数据

- (NSDictionary *)cellInfoAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *cellInfo = [NSMutableDictionary dictionaryWithCapacity:0];
    if (self.MusicresponseObj) {
        
    NSDictionary *cellInfoDic = self.MusicresponseObj[@"result"][@"playlists"][indexPath.row];
    cellInfo[@"musicListId"] = cellInfoDic[@"id"];
    cellInfo[@"musicListTitle"] = cellInfoDic[@"name"];
    cellInfo[@"musicListImage"] = cellInfoDic[@"coverImgUrl"];
    return cellInfo;
    
    }else {
        
        NSDictionary *cellInfoDic = @{@"musicListId":@1,@"musicListTitle":@"无网络数据",@"musicListImage":@""};
        cellInfo[@"musicListId"] = cellInfoDic[@"musicListId"];
        cellInfo[@"musicListTitle"] = cellInfoDic[@"musicListTitle"];
        cellInfo[@"musicListImage"] = cellInfoDic[@"musicListImage"];
        return cellInfo;

        
    }
    
}

- (NSInteger)numberOfSections {
    
    NSArray *array = self.MusicresponseObj[@"result"][@"playlists"];
    
    return array.count;
}
#pragma mark - 网络请求

- (void)postMusicListResult:(NSString *)string WithMusicType:(NSString *)type {
    
    NSDictionary *postDic = @{
                              @"s" : string,
                              @"type" : type,
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
        self.MusicresponseObj = object;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
