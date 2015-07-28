//
//  MusicModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/23.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MusicModel.h"
#import "PublicClass.h"

@implementation MusicModel
- (instancetype)initWithDictionary:(NSDictionary *)Dic {
    
    self = [super init];
    if (self) {
        
        self.musicListId = Dic[@"id"];
        self.musicListTitle = Dic[@"name"];
        self.musicListImage = Dic[@"coverImgUrl"];
        
    }
    
    return self;
}
#pragma mark - NSCoding methods
//将当前属性赋值进去
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_musicListId forKey:@"musicListId"];
    [aCoder encodeObject:_musicListTitle forKey:@"musicListTitle"];
    [aCoder encodeObject:_musicListImage forKey:@"musicListImage"];
}

@end
