//
//  SearchView.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/22.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WeChatBlock)();
typedef void (^PersonInfoBlock)();
typedef void (^SearchBlock)();
@interface SearchView : UIView
@property (nonatomic,copy)WeChatBlock weChatBlock;
@property (nonatomic,copy)PersonInfoBlock personInfoBlock;
@property (nonatomic,copy)SearchBlock searchBlock;
@end
