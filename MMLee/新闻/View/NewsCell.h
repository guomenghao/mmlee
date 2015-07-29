//
//  SXNewsCell.h
//  MMLee
//
//  Created by 郭梦浩 on 15-1-22.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell

@property(nonatomic,strong) NewsModel *NewsModel;



/**
 *  类方法返回可重用的id
 */
+ (NSString *)idForRow:(NewsModel *)NewsModel;

/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(NewsModel *)NewsModel;
@end
