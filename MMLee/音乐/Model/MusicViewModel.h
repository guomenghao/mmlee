//
//  MusicViewModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/23.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicViewModel : NSObject
@property (nonatomic,strong)id MusicresponseObj;
- (NSDictionary *)cellInfoAtIndexPath:(NSIndexPath *)indexPath;
- (void)postMusicListResult:(NSString *)string WithMusicType:(NSString *)type;
@end
