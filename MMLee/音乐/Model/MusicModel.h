//
//  MusicModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/23.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject
@property (nonatomic,strong)NSString *musicListId;
@property (nonatomic,strong)NSString *musicListImage;
@property (nonatomic,strong)NSString *musicListTitle;
- (instancetype)initWithDictionary:(NSDictionary *)Dic;
@end
