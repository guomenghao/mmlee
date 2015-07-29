//
//  SXReplyCell.h
//  MMLee
//
//  Created by 郭梦浩 on 15/2/8.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsReplyModel.h"

@interface NewsReplyCell : UITableViewCell

@property(nonatomic,strong) NewsReplyModel *replyModel;
/** 用户的发言 */
@property (weak, nonatomic) IBOutlet UILabel *sayLabel;
@end
