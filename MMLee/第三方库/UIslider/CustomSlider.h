//
//  CustomSlider.h
//  亲密互动
//
//  Created by 郭梦浩 on 15/5/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDProgressView.h"
@interface CustomSlider : UIView
@property(nonatomic,strong)LDProgressView *progressView;
@property(nonatomic,strong)UISlider *slider;
@end
