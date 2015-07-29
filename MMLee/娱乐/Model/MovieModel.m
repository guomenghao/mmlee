//
//  MovieModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel
- (instancetype)initWithDictionary:(NSDictionary *)Dic {
    
    self = [super init];
    if (self) {
        
       [self setValuesForKeysWithDictionary:Dic];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.movieId forKey:@"movieId"];
    [aCoder encodeObject:self.movieName forKey:@"movieName"];
    [aCoder encodeObject:self.pic_url forKey:@"pic_url"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
        self.movieId = [aDecoder decodeObjectForKey:@"movieId"];
        self.movieName = [aDecoder decodeObjectForKey:@"movieName"];
        self.pic_url = [aDecoder decodeObjectForKey:@"pic_url"];
    }
    return self;
}
@end
