//
//  MusicInfoModel.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MusicInfoModel.h"

@implementation MusicInfoModel
- (instancetype)initWithDictionary:(NSDictionary *)Dic {
    
    self = [super init];
    if (self) {
        
        self.musicUrl = Dic[@"mp3Url"];
        self.musicImage = Dic[@"album"][@"blurPicUrl"];
        self.musicTitle = Dic[@"name"];
        self.musicArtist = Dic[@"album"][@"artists"][0][@"name"];
        self.musicAlbum = Dic[@"album"][@"name"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.musicUrl forKey:@"url"];
    [aCoder encodeObject:self.musicImage forKey:@"image"];
    [aCoder encodeObject:self.musicTitle forKey:@"title"];
    [aCoder encodeObject:self.musicArtist forKey:@"artist"];
    [aCoder encodeObject:self.musicAlbum forKey:@"album"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        
        self.musicUrl = [aDecoder decodeObjectForKey:@"url"];
        self.musicImage = [aDecoder decodeObjectForKey:@"image"];
        self.musicTitle = [aDecoder decodeObjectForKey:@"title"];
        self.musicArtist = [aDecoder decodeObjectForKey:@"artist"];
        self.musicAlbum = [aDecoder decodeObjectForKey:@"album"];
    }
    return self;
}
@end
