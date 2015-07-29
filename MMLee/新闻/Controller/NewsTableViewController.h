//
//  NewsTableViewController.h
//  MMLee
//
//  Created by 郭梦浩 on 15-1-22.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController

/**
 *  url端口
 */
@property(nonatomic,copy) NSString *urlString;

@property (nonatomic,assign) NSInteger index;


@end
