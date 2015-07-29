//
//  MovieModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject
@property (nonatomic, strong) NSString *movieId;
@property (nonatomic, strong) NSString *movieName;
@property (nonatomic, strong) NSString *pic_url;
- (instancetype)initWithDictionary:(NSDictionary *)Dic;
@end
