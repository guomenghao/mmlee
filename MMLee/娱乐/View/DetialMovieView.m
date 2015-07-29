//
//  DetialMovieView.m
//  MMLee
//
//  Created by 郭梦浩 on 15/5/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "DetialMovieView.h"
#import <SDWebImageManager.h>
#import "ConnectingCheck.h"
#import <UIImageView+WebCache.h>

#define Actor_font [UIFont systemFontOfSize:17 weight:2]
#define Plot_font [UIFont systemFontOfSize:17]

@interface  DetialMovieView ()<UIScrollViewDelegate> {
    
    UIScrollView *_wholePageScrollView;
    UIImageView *_posterImageView;
    UIImageView *_backgroundView;
    UILabel *_movieTitleLabel;
    UILabel *_directorsLabel;
    UILabel *_filmLocationLabel;
    UILabel *_actorsLabel;
    UILabel *_countrylabel;
    UILabel *_plotSimpleLabel;
    UILabel *_genresLabel;
    UIView *_footView;
    UIButton *_shareButton;
    UIImageView *_datingImageView;
}


- (void)initializeAppearance;
- (UIImageView *)imageView;
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
- (void)shareButtonPress:(UIButton *)sender;

@end

@implementation DetialMovieView

- (instancetype)initWithFrame:(CGRect)frame MoveName:(NSString *)movieName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initializeAppearance];

    }
    return self;
}


- (void)initializeAppearance {
    
    
    _wholePageScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _wholePageScrollView.delegate = self;
    
    CGFloat margin = 10;
    //电影海报
    _posterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 74, 100, 150)];
    _posterImageView.layer.cornerRadius = 5;
    _posterImageView.layer.masksToBounds = YES;
    _posterImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _posterImageView.layer.shadowOffset = CGSizeMake(10, 10);
    _posterImageView.layer.shadowRadius = 10;
    _posterImageView.layer.shadowOpacity = YES;
    [_wholePageScrollView addSubview:_posterImageView];
    
    //电影名
    _movieTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_posterImageView.frame) + margin, CGRectGetMinY(_posterImageView.frame), CGRectGetWidth(self.bounds) - CGRectGetWidth(_posterImageView.frame) - 3 * margin, 30)];
    _movieTitleLabel.font = [UIFont systemFontOfSize:19 weight:2];
    [_wholePageScrollView addSubview:_movieTitleLabel];
    
    //导演
    _directorsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_posterImageView.frame) + margin, CGRectGetMaxY(_movieTitleLabel.frame) + margin, CGRectGetWidth(self.bounds) - CGRectGetWidth(_posterImageView.frame) - 3 * margin, 30)];
    _directorsLabel.font = [UIFont systemFontOfSize:18 weight:2];
    [_wholePageScrollView addSubview:_directorsLabel];
    
    //电影类型
    _genresLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_posterImageView.frame) + margin, CGRectGetMaxY(_directorsLabel.frame) + margin, CGRectGetWidth(self.bounds) - CGRectGetWidth(_posterImageView.frame) - 3 * margin, 30)];
    _genresLabel.font = [UIFont systemFontOfSize:18 weight:2];
    [_wholePageScrollView addSubview:_genresLabel];
    
    //电影所属国家
    _countrylabel = ({
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_posterImageView.frame) + margin, CGRectGetMaxY(_genresLabel.frame) + margin, CGRectGetWidth(self.bounds) - CGRectGetWidth(_posterImageView.frame) - 3 * margin, 30)];
        label.font = [UIFont systemFontOfSize:18 weight:2];
        label;
    });
    
    [_wholePageScrollView addSubview:_countrylabel];
    
    //分享按钮
    _shareButton = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds) - 100) / 2, CGRectGetMaxY(_posterImageView.frame) + margin, 100, 30)];
    [_shareButton setTitle:@"去约小伙伴"  forState:UIControlStateNormal];
    _shareButton.backgroundColor = [UIColor orangeColor];
    _shareButton.layer.cornerRadius = 10;
    _shareButton.layer.masksToBounds = YES;
    _shareButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:2];
    [_shareButton addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [_wholePageScrollView addSubview:_shareButton];
    
    //约伙伴飞入view
    _datingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    _datingImageView.center = _shareButton.center;
    _datingImageView.image = [UIImage imageNamed:@"yue"];
    _datingImageView.contentMode = UIViewContentModeScaleAspectFit;
    _datingImageView.hidden = YES;
    [_wholePageScrollView addSubview:_datingImageView];
    
    //下部分View
    _footView = ({
    
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = [[UIColor alloc] initWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        footView.layer.cornerRadius = 10;
        footView.layer.masksToBounds = YES;
        footView.layer.shadowColor = [UIColor blackColor].CGColor;
        footView.layer.shadowOffset = CGSizeMake(10, 10);
        footView.layer.shadowRadius = 10;
        footView.layer.shadowOpacity = YES;
        footView;

    });
    [_wholePageScrollView addSubview:_footView];
    
    
    //演员
    _actorsLabel = [[UILabel alloc] init];
    _actorsLabel.font = Actor_font;
    _actorsLabel.numberOfLines = 0;
    [_footView addSubview:_actorsLabel];
    
    //电影内容概要
    _plotSimpleLabel = [[UILabel alloc] init];
    _plotSimpleLabel.font = Plot_font;
    _plotSimpleLabel.numberOfLines = 0;
    [_footView addSubview:_plotSimpleLabel];
    
    //背景模糊图层
    _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    UIBlurEffect *be = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *veView = [[UIVisualEffectView alloc] initWithEffect:be];
    veView.frame = self.bounds;
    
    [_backgroundView addSubview:veView];
    [self addSubview:_backgroundView];
    [self addSubview:_wholePageScrollView];

    
}

/**
 *  为界面上的所有需要从网上取得数据的部件赋值
 *
 *  @param movieName 电影名
 */
- (void)loadDetailDataSourceWith:(NSDictionary *)Dic {
    
    NSString *postURL = [Dic objectForKey:@"poster"];
    [_posterImageView sd_setImageWithURL:[NSURL URLWithString:postURL]];
    [_backgroundView sd_setImageWithURL:[NSURL URLWithString:postURL]];
    NSString *title = [Dic objectForKey:@"title"];
    _movieTitleLabel.text = title;
    NSString *directors = [Dic objectForKey:@"directors"];
    _directorsLabel.text = [NSString stringWithFormat:@"导演：%@", directors];
    NSString *genres = [Dic objectForKey:@"genres"];
    _genresLabel.text = [NSString stringWithFormat:@"类型：%@", genres];
    NSString *country = [Dic objectForKey:@"country"];
    if (country) {
        _countrylabel.text = [NSString stringWithFormat:@"国家：%@", country];
    }
    CGFloat margin = 10;
    NSString *actors = [Dic objectForKey:@"actors"];
    actors = [NSString stringWithFormat:@"演员：\n%@", actors];
    CGSize actorSize = [self sizeWithText:actors font:Actor_font maxSize:CGSizeMake(CGRectGetWidth(self.bounds) - 2 * margin, MAXFLOAT)];
    _actorsLabel.text = actors;
    _actorsLabel.frame = CGRectMake(0, margin, actorSize.width, actorSize.height);
    
    NSString *plot = [Dic objectForKey:@"plot_simple"];
    plot = [NSString stringWithFormat:@"故事介绍：\n%@", plot];
    CGSize plotSize = [self sizeWithText:plot font:Plot_font maxSize:CGSizeMake(CGRectGetWidth(self.bounds) - 2 * margin, MAXFLOAT)];
    _plotSimpleLabel.text = plot;
    
    _plotSimpleLabel.frame = CGRectMake(0, CGRectGetMaxY(_actorsLabel.frame) + margin, plotSize.width, plotSize.height);
    
    _footView.frame = CGRectMake(margin, CGRectGetMaxY(_shareButton.frame) + margin, CGRectGetWidth(self.bounds) - 2 * margin, CGRectGetMaxY(_plotSimpleLabel.frame) + margin);
    
    _wholePageScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetMaxY(_footView.frame) + margin);
    
    
}
/**
 *  计算部件大小
 *
 *  @param text    文字内容
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *
 *  @return 部件size
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

/**
 *  展示『约』字
 */
- (void)showDatingImageView {
    
    _datingImageView.hidden = NO;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.duration = 0.3;
    scale.fromValue = @1.0;
    scale.toValue = @0.5;
    scale.removedOnCompletion = NO;
    scale.fillMode = kCAFillModeBoth;
    
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.duration = 0.3;
    rotate.fromValue = @0;
    rotate.toValue = @M_PI_4;
    rotate.removedOnCompletion = NO;
    rotate.fillMode = kCAFillModeBoth;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[scale, rotate];
    group.duration = 0.3;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    group.delegate = self;
    [_datingImageView.layer addAnimation:group forKey:@"group"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _datingImageView.transform = CGAffineTransformIdentity;
        _datingImageView.hidden = YES;
    });
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.delegate detialmovieViewDidScrollContentOffset:scrollView.contentOffset];
}

#pragma mark - <CAAnimationDelegate>

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _datingImageView.transform = CGAffineTransformIdentity;
            _datingImageView.hidden = YES;

        });
    }
}


#pragma mark - event

- (void)shareButtonPress:(UIButton *)sender {
    
    [self.delegate detialMovieViewShareButtonPress:sender];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
