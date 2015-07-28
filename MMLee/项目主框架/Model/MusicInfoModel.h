//
//  MusicInfoModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicInfoModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *musicTitle;
@property(nonatomic,copy)NSString *musicArtist;
@property(nonatomic,copy)NSString *musicAlbum;
@property(nonatomic,copy)NSString *musicImage;
@property(nonatomic,copy)NSString *musicUrl;

- (instancetype)initWithDictionary:(NSDictionary *)Dic;
@end
