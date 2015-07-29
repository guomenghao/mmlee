//
//  SXDetailImgModel.h
//  MMLee
//
//  Created by 郭梦浩 on 15-1-24.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailImgModel : NSObject

@property (nonatomic, copy) NSString *src;
/** 图片尺寸 */
@property (nonatomic, copy) NSString *pixel;
/** 图片所处的位置 */
@property (nonatomic, copy) NSString *ref;

+ (instancetype)detailImgWithDict:(NSDictionary *)dict;

@end
