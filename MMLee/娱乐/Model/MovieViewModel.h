//
//  MovieViewModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieViewModel : NSObject
@property (nonatomic,strong)id movieListResponseObject;
@property (nonatomic,strong)id movieInfoResponseObject;
@property (nonatomic,strong)id movieWithNameResponseObject;
- (void)postMovieList;
- (void)postMovieInfo:(NSString *)movieId;
- (void)postMovieInfoWith:(NSString *)movieName;
@end
