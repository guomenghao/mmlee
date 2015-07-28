//
//  InfoTableViewCell.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/22.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *info;
@property (strong, nonatomic) IBOutlet UILabel *time;

- (void)updateCellInfo:(NSDictionary *)Dic;
@end
