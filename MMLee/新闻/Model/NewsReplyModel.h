//
//  SXReplyModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15/2/9.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsReplyModel : NSObject

/** 用户的姓名 */
@property(nonatomic,copy) NSString *name;
/** 用户的ip信息 */
@property(nonatomic,copy) NSString *address;
/** 用户的发言 */
@property(nonatomic,copy) NSString *say;
/** 用户的点赞 */
@property(nonatomic,copy) NSString *suppose;

@end
