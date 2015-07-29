//
//  SXDetailController.h
//  MMLee
//
//  Created by 郭梦浩 on 15-1-24.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsDetailController : UIViewController

@property(nonatomic,strong) NewsModel *newsModel;

@property (nonatomic,assign) NSInteger index;
- (IBAction)getBackButton:(UIButton *)sender;
- (IBAction)repalyButton:(UIButton *)sender;


@end
