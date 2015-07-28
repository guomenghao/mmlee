//
//  MusicInfoViewModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicInfoViewModel : NSObject
@property (nonatomic,strong)NSMutableArray *MusicSearchPonseObj;
- (void)postSearchMusic:(NSString *)searchText;
@end
