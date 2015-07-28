//
//  MusicPlayView.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface MusicPlayView : UIView
@property (nonatomic,strong)NSTimer *musicTimer;
@property (nonatomic,strong)CCAudioPlayer *audioPlayer;
- (void)updateMusicPlane;
@end
