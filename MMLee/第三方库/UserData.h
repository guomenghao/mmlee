//
//  UserData.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicInfoModel.h"
@interface UserData : NSObject
@property (nonatomic,strong)MusicInfoModel *musicInfoModel;
@property (nonatomic,strong)NSMutableArray *musicList;
@property (nonatomic, assign)NSInteger isLogin;
@property (nonatomic,strong)NSString *userName;
+ (UserData *)shareInstance;
@end
