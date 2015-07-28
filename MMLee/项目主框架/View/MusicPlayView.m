//
//  MusicPlayView.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MusicPlayView.h"
#import "PublicClass.h"
#import "WriteAndReadMethod.h"
#import "CustomSlider.h"
#import "MusicInfoModel.h"
#import "UserData.h"
#import "UIImageView+WebCache.h"
#import <AFNetworking/AFNetworking.h>
@interface MusicPlayView () <UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _musicTimeCount;
    
    NSMutableArray *_musicList;
    
    NSInteger _currentPlayIndex;
    
    NSMutableArray *_timeArray;
    NSMutableDictionary *_LRCDictionary;
    NSUInteger _lrcLineNumber;
}
@property (nonatomic,strong)UIImageView *musicInfoImage;
@property (nonatomic,strong)UIImageView *musicBackImage;
@property (nonatomic,strong)UIButton *nextMusic;
@property (nonatomic,strong)UIButton *preMusic;
@property (nonatomic,strong)UIButton *playMusic;
@property (nonatomic,strong)UIButton *likeButton;
@property (nonatomic,strong)UIButton *shareButton;
@property (nonatomic,strong)UIButton *expandButton;
@property (nonatomic,strong)UILabel *musicTitle;
@property (nonatomic,strong)UILabel *musicArtist;
@property (nonatomic,strong)UILabel *musicAlbum;
@property (nonatomic,strong)UILabel *nextTime;
@property (nonatomic,strong)CustomSlider *customSlider;
@property (nonatomic,assign)BOOL isExpand;
@property (nonatomic,assign)BOOL isPlaying;
@property (nonatomic,assign)CGRect currentRect;
@property (nonatomic,strong)NSMutableArray *musicList;
@property (nonatomic,strong)MusicInfoModel *musicModel;
@property (nonatomic,strong)CABasicAnimation *rotationAnimation;
@property (nonatomic,strong)UITableView *lrcTableView;
- (void)initilazeDataSoucre;
- (void)initilazeApearance;
@end
@implementation MusicPlayView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _currentRect = frame;
        [self initilazeDataSoucre];
        [self initilazeApearance];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    draw4Rect();
}
void draw4Rect()
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画矩形
    CGContextAddRect(ctx, CGRectMake(0, 0,WIDTH, 260.0 / AUTOLAYOUT_Y));
    
    // set : 同时设置为实心和空心颜色
    // setStroke : 设置空心颜色
    // setFill : 设置实心颜色
    [[UIColor orangeColor] set];
    
    //    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    
    // 3.绘制图形
    CGContextFillPath(ctx);
}

#pragma mark - getter

- (UIButton *)expandButton {
    
    if (!_expandButton) {
        
        _expandButton = ({
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(320 / AUTOLAYOUT_X, 12 / AUTOLAYOUT_Y, 30 / AUTOLAYOUT_X, 30 / AUTOLAYOUT_Y)];
            [button setImage:[UIImage imageNamed:@"iconfont-iosarrowup"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonPressExpand:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    
    return _expandButton;
}

- (CustomSlider *)customSlider {
    
    _customSlider = ({
        
        CustomSlider *customSlider = [[CustomSlider alloc] initWithFrame:CGRectMake(80 / AUTOLAYOUT_X, 20 / AUTOLAYOUT_Y, 220 / AUTOLAYOUT_X, 20 / AUTOLAYOUT_Y)];
        [customSlider.slider addTarget:self action:@selector(PressSliderValueChange:) forControlEvents:UIControlEventValueChanged];
        customSlider;
    });
    return _customSlider;
}

- (UIImageView *)musicBackImage {
    
    if (!_musicBackImage) {
        
        _musicBackImage = ({
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(20 / AUTOLAYOUT_X , 5 / AUTOLAYOUT_Y, 50 / AUTOLAYOUT_X, 50 / AUTOLAYOUT_Y);
            imageView.image = [UIImage imageNamed:@"album"];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = CGRectGetMaxX(self.bounds) * (50.0 / 375) / 2;
            imageView;
        });
    }
    return _musicBackImage;

}

- (UIImageView *)musicInfoImage {
    
    if (!_musicInfoImage) {
        
        _musicInfoImage = ({
            
            UIImageView *musicInfoBackImage = [[UIImageView alloc] init];
            musicInfoBackImage.bounds = CGRectMake(0, 0, 220.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 220.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds));
            musicInfoBackImage.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), 135   + CGRectGetHeight(musicInfoBackImage.bounds) / 2);
            musicInfoBackImage.image = [UIImage imageNamed:@"headlengthpng"];
            musicInfoBackImage.alpha = 0;
            musicInfoBackImage;
        });
    }
    return _musicInfoImage;
}

- (UILabel *)musicTitle {
    
    _musicTitle = ({
        
         UILabel *musicTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 14.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds), 200.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 60.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds))];
        musicTitle.textColor = [UIColor whiteColor];
        musicTitle.font = [UIFont fontWithName:@"AmericanTypewriter" size:25];
        musicTitle.alpha = 0;
        musicTitle.textAlignment = NSTextAlignmentLeft;
        musicTitle;
    });
    return _musicTitle;
}

- (UILabel *)musicArtist {
    
    _musicArtist = ({
        
         UILabel *musicArtist = [[UILabel alloc] initWithFrame:CGRectMake(20.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 75.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds), 250.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 20.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds))];
        musicArtist.font = [UIFont systemFontOfSize:16];
        musicArtist.textColor = [UIColor whiteColor];
        musicArtist.alpha = 0;
        musicArtist.textAlignment = NSTextAlignmentLeft;
        musicArtist;
    });
    return _musicTitle;
}

- (UILabel *)musicAlbum {
    
    _musicAlbum = ({
        
        UILabel *musicAlbum = [[UILabel alloc] initWithFrame:CGRectMake(20.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 110.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds), 250.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 20.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds))];
        musicAlbum.font = [UIFont systemFontOfSize:16];
        musicAlbum.textColor = [UIColor whiteColor];
        musicAlbum.alpha = 0;
        musicAlbum.textAlignment = NSTextAlignmentLeft;
        musicAlbum;
    });
    return _musicAlbum;
}

- (UILabel *)nextTime {
    
    _nextTime = ({
        
        UILabel *nextTime = [[UILabel alloc] initWithFrame:CGRectMake(20.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 145.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds), 250.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 20.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds))];
        nextTime.font = [UIFont systemFontOfSize:16];
        nextTime.textColor = [UIColor whiteColor];
        nextTime.alpha = 0;
        nextTime.textAlignment = NSTextAlignmentLeft;
        nextTime;
    });
    return _nextTime;
}

- (UIButton *)likeButton {
    
    _likeButton = ({
        
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        likeButton.bounds = CGRectMake(0, 0, 60.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 60.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds));
        likeButton.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2.0);
        [likeButton setImage:[UIImage imageNamed:@"shouye_03-06"] forState:UIControlStateNormal];
        likeButton.alpha = 0;
        likeButton;
    });
    return _likeButton;
}

- (UIButton *)shareButton {
    
    _shareButton = ({
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.bounds = CGRectMake(0, 0, 60.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 60.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds));
        shareButton.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2.0);
        [shareButton setImage:[UIImage imageNamed:@"shouye_03"] forState:UIControlStateNormal];
        shareButton.alpha = 0;
        shareButton;
        
        });
    return _shareButton;
}

- (UIButton *)preMusic {
    
    _preMusic = ({
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 60.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 60.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds));
        button.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2.0);
        [button setImage:[UIImage imageNamed:@"shouye_11-14"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressPre:) forControlEvents:UIControlEventTouchUpInside];
        button.alpha = 0;
        button;
        
    });
    return _preMusic;
}

- (UIButton *)nextMusic {
    
    _nextMusic = ({
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 60.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 60.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds));
        button.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2.0);
        [button setImage:[UIImage imageNamed:@"shouye_09-10"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressNext:) forControlEvents:UIControlEventTouchUpInside];
        button.alpha = 0;
        button;
        
    });
    return _nextMusic;
}

- (UIButton *)playMusic {
    
    _playMusic = ({
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 85.0 / 375 * CGRectGetMaxX([UIScreen mainScreen].bounds), 85.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds));
        button.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2.0);
        [button setImage:[UIImage imageNamed:@"shouye_17"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressPlay:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"shouye_23"] forState:UIControlStateSelected];
        button.alpha = 0;
        button;
    });
    return _playMusic;
}

- (UITableView *)lrcTableView {
    
    if (!_lrcTableView) {
        
        _lrcTableView = ({
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(35 / AUTOLAYOUT_X, 480 / AUTOLAYOUT_Y, 287 / AUTOLAYOUT_X, 100 / AUTOLAYOUT_Y)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.separatorStyle = UITableViewCellSelectionStyleNone;
            tableView;
        });
    }
    return _lrcTableView;
}

- (void)initilazeDataSoucre {
    
    _isExpand = NO;
    
}

- (void)initilazeApearance {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.musicInfoImage];
    [self addSubview:self.musicBackImage];
    [self addSubview:self.musicTitle];
    [self addSubview:self.musicArtist];
    [self addSubview:self.musicAlbum];
    [self addSubview:self.nextTime];
    [self addSubview:self.likeButton];
    [self addSubview:self.shareButton];
    [self addSubview:self.preMusic];
    [self addSubview:self.nextMusic];
    [self addSubview:self.playMusic];
    [self addSubview:self.customSlider];
    [self addSubview:self.expandButton];
    [self addSubview:self.lrcTableView];
    
    
    
}

#pragma mark - 按钮事件

- (void)PressSliderValueChange:(UISlider *)sender {
    
    _customSlider.progressView.progress = sender.value;
    [_audioPlayer seekToTime:sender.value * _audioPlayer.duration];
}

- (void)buttonPressPlay:(UIButton *)sender {
    
    if (_isPlaying) {
        
        _isPlaying = NO;
        sender.selected = !_isPlaying;
        [_audioPlayer pause];
        [_musicTimer invalidate];
        _musicTimer = nil;
        
        
    }else {
        
        _isPlaying = YES;
        sender.selected = !_isPlaying;
        [_audioPlayer play];
        [self startMusicTime];
    }
}

- (void)buttonPressNext:(UIButton *)sender {
    
    _currentPlayIndex++;
    _currentPlayIndex = [self getCurrentPlayIndex:_currentPlayIndex];
    _musicModel = _musicList[_currentPlayIndex];
    [_audioPlayer dispose];
    [self updateMusicPlaneNextAndPre];
}

- (void)buttonPressPre:(UIButton *)sender {
    
    _currentPlayIndex--;
    _currentPlayIndex = [self getCurrentPlayIndex:_currentPlayIndex];
    _musicModel = _musicList[_currentPlayIndex];
    [_audioPlayer dispose];
    [self updateMusicPlaneNextAndPre];
}

- (NSInteger)getCurrentPlayIndex:(NSInteger)index {
    
    if (_currentPlayIndex > _musicList.count - 1) {
        
        _currentPlayIndex = 0;
        return _currentPlayIndex;
    }
    else
        if (_currentPlayIndex < 0) {
            
            _currentPlayIndex = _musicList.count - 1;
            return _currentPlayIndex;
        }else {
            
            return _currentPlayIndex;
        }
}

- (void)updateMusicPlaneNextAndPre {
    [self.musicTimer invalidate];
    _musicTitle.text = _musicModel.musicTitle;
    [_musicBackImage sd_setImageWithURL:[NSURL URLWithString:_musicModel.musicImage]];
    _musicArtist.text = _musicModel.musicArtist;
    _musicAlbum.text = _musicModel.musicAlbum;
    _customSlider.slider.value = 0.0;
    _customSlider.progressView.progress = 0.0;
    [self initializeMusicPlayer:_musicModel.musicUrl];
    
}

- (void)updateMusicPlane {
    [self.musicTimer invalidate];
    UserData *userData = [UserData shareInstance];
    _musicModel = userData.musicInfoModel;
    _musicTitle.text = _musicModel.musicTitle;
    [_musicBackImage sd_setImageWithURL:[NSURL URLWithString:_musicModel.musicImage]];
    _musicArtist.text = _musicModel.musicArtist;
    _musicAlbum.text = _musicModel.musicAlbum;
    [self initializeMusicPlayer:_musicModel.musicUrl];
    
}


- (void)buttonPressExpand:(UIButton *)sender {
    
    _isExpand = !_isExpand;
    if (_isExpand == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            
            [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            _musicInfoImage.alpha = 1;
            [_customSlider setFrame:CGRectMake(80 / AUTOLAYOUT_X, 627 / AUTOLAYOUT_Y, 220 / AUTOLAYOUT_X, 20 / AUTOLAYOUT_Y)];
            _musicBackImage.bounds = CGRectMake(0, 0, 50.0 / AUTOLAYOUT_X, 50.0 / AUTOLAYOUT_Y);
            _musicBackImage.center = CGPointMake(CGRectGetMidX(self.bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2);
            _musicBackImage.transform = CGAffineTransformMakeScale(188.0 / 50, 188.0 / 50);
            _expandButton.transform = CGAffineTransformRotate(_expandButton.transform, M_PI);
            
            
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                _likeButton.center = CGPointMake(40.0 / AUTOLAYOUT_X, 320.0 / AUTOLAYOUT_Y);
                _shareButton.center = CGPointMake(335.0 / AUTOLAYOUT_X, 320.0 / AUTOLAYOUT_Y);
                _preMusic.center = CGPointMake(90.0 / AUTOLAYOUT_X, 380.0 / AUTOLAYOUT_Y);
                _nextMusic.center = CGPointMake(285.0 / AUTOLAYOUT_X, 380.0 / AUTOLAYOUT_Y);
                _playMusic.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), 420.0 / 667 * CGRectGetMaxY([UIScreen mainScreen].bounds));
                _likeButton.alpha = 1;
                _shareButton.alpha = 1;
                _preMusic.alpha = 1;
                _nextMusic.alpha = 1;
                _playMusic.alpha = 1;
                
                _musicTitle.alpha = 1;
                _musicArtist.alpha = 1;
                _musicAlbum.alpha = 1;
                _nextTime.alpha = 1;
                
                
            }];
            
            
            
        }];

    }else {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _likeButton.center = CGPointMake(CGRectGetMidX(self.bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2);
            _shareButton.center = CGPointMake(CGRectGetMidX(self.bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2);
            _preMusic.center = CGPointMake(CGRectGetMidX(self.bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2);
            _nextMusic.center = CGPointMake(CGRectGetMidX(self.bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2);
            _playMusic.center = CGPointMake(CGRectGetMidX(self.bounds), 135   + CGRectGetHeight(_musicInfoImage.bounds) / 2);
            _expandButton.transform = CGAffineTransformRotate(_expandButton.transform, M_PI);
            _likeButton.alpha = 0;
            _shareButton.alpha = 0;
            _preMusic.alpha = 0;
            _nextMusic.alpha = 0;
            _playMusic.alpha = 0;
            
            _musicTitle.alpha = 0;
            _musicArtist.alpha = 0;
            _musicAlbum.alpha = 0;
            _nextTime.alpha = 0;
            
            
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                [self setFrame:_currentRect];
                [_customSlider setFrame:CGRectMake(80 / AUTOLAYOUT_X, 20 / AUTOLAYOUT_Y, 220 / AUTOLAYOUT_X, 20 / AUTOLAYOUT_Y)];
                _musicInfoImage.alpha = 0;
                
                _musicBackImage.transform = CGAffineTransformMakeScale(1.0, 1.0);
                _musicBackImage.center = CGPointMake(35 / AUTOLAYOUT_X, 60.0 / 2 / AUTOLAYOUT_Y);
                
            }];
            
            
        }];
        
    }

}

#pragma mark - 播放
- (void)initializeMusicPlayer:(NSString *)musicUrl {
    
    UserData *userData = [UserData shareInstance];
    self.musicList = userData.musicList;
    if (_isPlaying == YES) {
        
        [_audioPlayer dispose];
    }
    _isPlaying = YES;
    [self getMusicLrcResult];
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@",musicUrl]];
    _audioPlayer = [CCAudioPlayer audioPlayerWithContentsOfURL:url];
    //准备播放
    [_audioPlayer play];
    [self startMusicTime];
}

#pragma mark - 音乐旋转动画以及运动事件（NSTIMER）

- (void)startMusicTime {
    
    _musicTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(startMusicAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_musicTimer forMode:NSRunLoopCommonModes];
}


- (void)startMusicAnimation
{
    if (_audioPlayer.playerState == CCAudioPlayerStateStopped) {
        [_musicTimer invalidate];
        _currentPlayIndex++;
        _currentPlayIndex = [self getCurrentPlayIndex:_currentPlayIndex];
        _musicModel = _musicList[_currentPlayIndex];
        [_audioPlayer dispose];
        [self updateMusicPlaneNextAndPre];
    }
    [self updateProgresssIndicator];
    [self displaySondWord:_audioPlayer.progress];
    [UIView animateWithDuration:0.3 animations:^{
        
        _musicInfoImage.transform = CGAffineTransformRotate(_musicInfoImage.transform, M_PI / 60.0);
        
    }];
    
}

- (void)updateProgresssIndicator {
    
    //更新slier的显示值
    _customSlider.slider.value = (double)(_audioPlayer.progress / _audioPlayer.duration * 1);
    _customSlider.progressView.progress = (double)(_audioPlayer.progress / _audioPlayer.duration * 1);
    
    [self updateTimeLabel];
    
}

- (void)updateTimeLabel {
    
    
    //00:00
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss"];
    NSDate *remainDate = [NSDate dateWithTimeIntervalSince1970:_audioPlayer.duration - _audioPlayer.progress];
    _nextTime.text = [formatter stringFromDate:remainDate];
}
#pragma mark - 音乐歌词网络请求

- (void)getMusicLrcResult {
    
    NSString *url = [[NSString alloc] initWithFormat:@"http://geci.me/api/lyric/%@/%@",[_musicModel.musicTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_musicModel.musicArtist stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDic = responseObject;
        NSArray *arrayMusicLrc = resultDic[@"result"];
        if (arrayMusicLrc.count > 0) {
            
            NSString *url = ((NSDictionary *)arrayMusicLrc[0])[@"lrc"];
            [self downLoadLrcStr:url];
            
        }else {
            
            //初始化歌词词典
            _timeArray = [[NSMutableArray alloc] initWithCapacity:5];
            _LRCDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
            [self.lrcTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark - 歌词多线程下载
- (void)downLoadLrcStr:(NSString *)str {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        NSString *lrcString = [NSString stringWithContentsOfURL:filePath encoding:NSUTF8StringEncoding  error:nil];
        [self initLRC:lrcString];
        
    }];
    [downloadTask resume];}

#pragma mark 得到歌词
- (void)initLRC:(NSString *)lrcStr {
    
    //初始化歌词词典
    _timeArray = [[NSMutableArray alloc] initWithCapacity:5];
    _LRCDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    NSArray *array = [lrcStr componentsSeparatedByString:@"\n"];
    for (int i = 0; i < [array count]; i++) {
        NSString *linStr = [array objectAtIndex:i];
        NSArray *lineArray = [linStr componentsSeparatedByString:@"]"];
        if ([lineArray[0] length] > 8) {
            NSString *str1 = [linStr substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [linStr substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                NSString *lrcStr = [lineArray objectAtIndex:1];
                NSString *timeStr = [[lineArray objectAtIndex:0] substringWithRange:NSMakeRange(1, 5)];//分割区间求歌词时间
                //把时间 和 歌词 加入词典
                [_LRCDictionary setObject:lrcStr forKey:timeStr];
                [_timeArray addObject:timeStr];//timeArray的count就是行数
            }
        }
    }
}
#pragma mark 动态显示歌词
- (void)displaySondWord:(NSUInteger)time {
    //    NSLog(@"time = %u",time);
    for (int i = 0; i < [_timeArray count]; i++) {
        
        NSArray *array = [_timeArray[i] componentsSeparatedByString:@":"];//把时间转换成秒
        NSUInteger currentTime = [array[0] intValue] * 60 + [array[1] intValue];
        if (i == [_timeArray count]-1) {
            //求最后一句歌词的时间点
            NSArray *array1 = [_timeArray[_timeArray.count-1] componentsSeparatedByString:@":"];
            NSUInteger currentTime1 = [array1[0] intValue] * 60 + [array1[1] intValue];
            if (time > currentTime1) {
                [self updateLrcTableView:i];
                break;
            }
        } else {
            //求出第一句的时间点，在第一句显示前的时间内一直加载第一句
            NSArray *array2 = [_timeArray[0] componentsSeparatedByString:@":"];
            NSUInteger currentTime2 = [array2[0] intValue] * 60 + [array2[1] intValue];
            if (time < currentTime2) {
                [self updateLrcTableView:0];
                //                NSLog(@"马上到第一句");
                break;
            }
            //求出下一步的歌词时间点，然后计算区间
            NSArray *array3 = [_timeArray[i+1] componentsSeparatedByString:@":"];
            NSUInteger currentTime3 = [array3[0] intValue] * 60 + [array3[1] intValue];
            if (time >= currentTime && time <= currentTime3) {
                [self updateLrcTableView:i];
                break;
            }
            
        }
    }
}

#pragma mark 动态更新歌词表歌词
- (void)updateLrcTableView:(NSUInteger)lineNumber {
    //    NSLog(@"lrc = %@", [LRCDictionary objectForKey:[timeArray objectAtIndex:lineNumber]]);
    //重新载入 歌词列表lrcTabView
    _lrcLineNumber = lineNumber;
    [self.lrcTableView reloadData];
    //使被选中的行移到中间
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
    [self.lrcTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    //    NSLog(@"%i",lineNumber);
}
#pragma mark 歌词表格代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_timeArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LRCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//该表格选中后没有颜色
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == _lrcLineNumber) {
        cell.textLabel.text = _LRCDictionary[_timeArray[indexPath.row]];
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    } else {
        cell.textLabel.text = _LRCDictionary[_timeArray[indexPath.row]];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    //        cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //        [cell.contentView addSubview:lable];//往列表视图里加 label视图，然后自行布局
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}



@end
