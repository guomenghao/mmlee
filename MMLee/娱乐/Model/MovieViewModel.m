//
//  MovieViewModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MovieViewModel.h"
#import "MovieModel.h"
#import <AFNetworking/AFNetworking.h>
#import "JHAPISDK.h"
#import "ConnectingCheck.h"
@implementation MovieViewModel

- (void)postMovieList {
    
    NSDictionary *parameter = @{@"cityid" : @"6"};
    
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:@"http://v.juhe.cn/movie/movies.today" APIID:@"42" Parameters:parameter Method:@"GET" Success:^(id responseObject) {
        
        self.movieListResponseObject = responseObject;
        
    } Failure:^(NSError *error) {
        
    }];
}

- (void)postMovieInfo:(NSString *)movieId {
    
    NSDictionary *parameter = @{@"movieid" : movieId};

    
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:@"http://v.juhe.cn/movie/query" APIID:@"42" Parameters:parameter Method:@"GET" Success:^(id responseObject) {
        
        self.movieInfoResponseObject = responseObject;
        
    } Failure:^(NSError *error) {
        
    }];
}

- (void)postMovieInfoWith:(NSString *)movieName {
    
    NSDictionary *parameter = @{@"title" : movieName};
    
    if (![ConnectingCheck isConnectionAvailable]) {
        return;
    }
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:@"http://v.juhe.cn/movie/index" APIID:@"42" Parameters:parameter Method:@"GET" Success:^(id responseObject) {
        
        self.movieWithNameResponseObject = responseObject;
        
    } Failure:^(NSError *error) {
        
    }];
}


@end
