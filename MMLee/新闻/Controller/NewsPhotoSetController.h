//
//  SXPhotoSetController.h
//  MMLee
//
//  Created by 郭梦浩 on 15/2/3.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsPhotoSetController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhotos;

@property(nonatomic,strong) NewsModel *newsModel;
@end
