//
//  MainPageView.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/27.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "MainPageView.h"
#import <MapKit/MapKit.h>


#import "CustomButton.h"
#import "MovieModel.h"
#import "PublicClass.h"
#import <UIImageView+WebCache.h>
@interface MainPageView ()<PagedFlowViewDelegate, PagedFlowViewDataSource, UIScrollViewDelegate, CLLocationManagerDelegate> {

    NSMutableArray *_detailDataSourch;
    NSMutableArray *_cinemasArray;
   
}

@property (nonatomic,strong)CustomButton *cinemaButton;
@property (nonatomic,strong)CLLocationManager *locManager;
@property (nonatomic,strong)UIButton *detailBt;

- (void)initializeAppearance;
- (void)initializeDataSource;
@end
@implementation MainPageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initializeDataSource];
        [self initializeAppearance];
    }
    return self;
}

- (UIScrollView *)wholePageScrollView {
    
    if (!_wholePageScrollView) {
        _wholePageScrollView = ({
            
            UIScrollView *wholePageScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            wholePageScrollView.delegate = self;
            wholePageScrollView;
        });
    }
    return _wholePageScrollView;
}

- (PagedFlowView *)topView {
    
    if (!_topView) {
        _topView = ({
            
            PagedFlowView *view = [[PagedFlowView alloc] initWithFrame:CGRectMake(0, 80 / AUTOLAYOUT_Y, WIDTH, HEIGHT / 3.0)];
            view.delegate = self;
            view.dataSource = self;
            view.minimumPageAlpha = 0.5;
            view.minimumPageScale = 0.7;
            view;
        });
    }
    return _topView;
}

- (UILabel *)movieName {
    
    if (!_movieName) {
        
        _movieName = ({
            
            UILabel *movieName = [[UILabel alloc] init];
            movieName.textColor = [UIColor whiteColor];
            movieName.font = _fontDic[@"movieNameFont"];
            movieName.textAlignment = NSTextAlignmentCenter;
            movieName.backgroundColor = [UIColor clearColor];
            movieName;
        });
    }
    return _movieName;
}

- (RatingView *)ratingView {
    
    if (!_ratingView) {
        
        _ratingView = ({
            
            RatingView *ratingView = [[RatingView alloc] init];
            ratingView;
        });
    }
    return _ratingView;
}

- (UIView *)midView {
    
    if (!_midView) {
        
        _midView = ({
            
            UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(-CGRectGetWidth(self.bounds) , CGRectGetMidY(self.bounds) + 20, CGRectGetWidth(self.bounds) * 3, 200)];
            midView.backgroundColor = [UIColor whiteColor];
            midView.layer.cornerRadius = midView.frame.size.width / 2.0;
            midView.layer.masksToBounds = YES;
            midView;
        });
    }
    return _midView;
}

- (UIView *)detailView {
    
    if (!_detailView) {
        
        _detailView = ({
            
            UIView *detailView = [[UIView alloc] init];
            detailView.backgroundColor = [UIColor whiteColor];
            detailView;

        });
    }
    return _detailView;
}

- (UIButton *)detailBt {
    
    if (!_detailBt) {
        
        _detailBt = ({
            
            UIButton *detailBt = [UIButton buttonWithType:UIButtonTypeCustom];
            detailBt.bounds = CGRectMake(0, 0, 100, 30);
            detailBt.center = CGPointMake(CGRectGetMidX(self.bounds),CGRectGetMinY(_midView.frame));
            [detailBt setTitle:@"查看详情" forState:UIControlStateNormal];
            detailBt.titleLabel.font = [UIFont systemFontOfSize:15 weight:2];
            detailBt.titleLabel.textColor = [UIColor whiteColor];
            detailBt.layer.cornerRadius = CGRectGetHeight(detailBt.frame) / 2;
            detailBt.layer.masksToBounds = YES;
            [detailBt addTarget:self action:@selector(detialButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            detailBt.backgroundColor = [UIColor orangeColor];
            detailBt;
        });
    }
    return _detailBt;
}

- (CustomButton *)cinemaButton {
    
    if (!_cinemaButton) {
        
        _cinemaButton = ({
            
            CustomButton *button = [[CustomButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(_midView.bounds), CGRectGetMidY(_midView.bounds) - 100, CGRectGetWidth(self.bounds) / 2.0, 100)];
            button.titleString = @"附近影院";
            [button addTarget:self action:@selector(cinemaButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _cinemaButton;
}

- (UILabel *)actorsLabel {
    
    if (!_actorsLabel) {
        
        _actorsLabel = ({
            
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor whiteColor];
            label.font = _fontDic[@"actorsFont"];
            label.numberOfLines = 0;
            label;
        });
    }
    return _actorsLabel;
}

- (UILabel *)introduceLabel {
    
    if (!_introduceLabel) {
        
        _introduceLabel = ({
            
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor whiteColor];
            label.font = _fontDic[@"introduceFont"];
            label.textColor = [UIColor blackColor];
            label.numberOfLines = 0;
            label;
        });
    }
    return _introduceLabel;
}

- (UIImageView *)backgroundView {
    
    if (!_backgroundView) {
        
        _backgroundView = ({
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            UIBlurEffect *be = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *veView = [[UIVisualEffectView alloc] initWithEffect:be];
            veView.frame = self.bounds;
            
            [imageView addSubview:veView];
            imageView;
        });
    }
    return _backgroundView;
}

- (void)initializeDataSource {
    
    _fontDic = @{@"movieNameFont" : [UIFont systemFontOfSize:18 weight:4],
                 @"actorsFont" : [UIFont systemFontOfSize:18],
                 @"introduceFont" : [UIFont systemFontOfSize:17]};
    _dataSource = [NSMutableArray array];
    _detailDataSourch = [NSMutableArray array];
}

- (void)initializeAppearance {
    
    [self.wholePageScrollView addSubview:self.topView];
    [self.wholePageScrollView addSubview:self.movieName];
    [self.wholePageScrollView addSubview:self.ratingView];
    [self.wholePageScrollView addSubview:self.midView];
    [self.wholePageScrollView addSubview:self.detailBt];
    [self.midView addSubview:self.cinemaButton];
    [self.detailView addSubview:self.actorsLabel];
    [self.detailView addSubview:self.introduceLabel];
    [self.wholePageScrollView addSubview:self.detailView];
    [self addSubview:self.backgroundView];
    [self addSubview:self.wholePageScrollView];
    
    
}
#pragma mark - 按钮操作
- (void)detialButtonPress:(UIButton *)sender {
    
    [self.delegate mainPageViewDetialButtonPress:sender movieName:_movieName.text];
}

- (void)cinemaButtonPress:(CustomButton *)sender {
    
    [self.delegate mainPageViewCinameButtonPressWithCinemas:_cinemasArray];
    
}


#pragma mark - <PagedFlowViewDelegate, PagedFlowViewDataSource>

- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView {
    
    return CGSizeMake(180, 240);
}

- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView {
    
    return _dataSource.count;
}

- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 6;
        imageView.layer.masksToBounds = YES;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:_dataSource[index][@"pic_url"]]];
    if (index == 0) {
        MovieModel *model = [[MovieModel alloc] initWithDictionary:_dataSource[index]];
        [_backgroundView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
        _movieName.text = model.movieName;
        CGSize nameSize = [self sizeWithText:_movieName.text font:_fontDic[@"movieNameFont"] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _movieName.bounds = CGRectMake(0, 0, nameSize.width, nameSize.height);
        _movieName.center = CGPointMake(CGRectGetMidX(self.bounds) - nameSize.height / 2.0, CGRectGetMaxY(_topView.frame) + 15);
        
        _ratingView.frame = CGRectMake(CGRectGetMaxX(_movieName.frame) + 5, _movieName.frame.origin.y, _movieName.frame.size.height, _movieName.frame.size.height);
        [self.delegate movieInfoWithMovieId:model.movieId];
        
    }
    
    return imageView;
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    MovieModel *model = [[MovieModel alloc] initWithDictionary:_dataSource[index]];
    [_backgroundView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    _movieName.text = model.movieName;
    CGSize nameSize = [self sizeWithText:_movieName.text font:_fontDic[@"movieNameFont"] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _movieName.bounds = CGRectMake(0, 0, nameSize.width, nameSize.height);
    _movieName.center = CGPointMake(CGRectGetMidX(self.bounds) - nameSize.height / 2.0, CGRectGetMaxY(_topView.frame) + 15);
    
    _ratingView.frame = CGRectMake(CGRectGetMaxX(_movieName.frame) + 5, _movieName.frame.origin.y, _movieName.frame.size.height, _movieName.frame.size.height);
    [self.delegate movieInfoWithMovieId:model.movieId];
    
    
}

- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index {
    
    
    
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.delegate mainPageViewWholePageDidScrollToContentOffset:scrollView.contentOffset];
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


@end
