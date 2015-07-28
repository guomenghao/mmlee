//
//  SXNewsCell.h
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15-1-22.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
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
