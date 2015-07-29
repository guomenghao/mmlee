//
//  AmuseViewController.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/21.
//  Copyright © 2015年 郭梦浩. All rights reserved.
//

#import "AmuseViewController.h"
#import "MainPageView.h"
#import <MapKit/MapKit.h>
#import "MovieModel.h"
#import "MovieViewModel.h"
#import "DetailMovieViewController.h"
#import "CinemasViewController.h"
@interface AmuseViewController ()<MainPageViewDelegate, UISearchResultsUpdating>
@property (nonatomic,strong)MainPageView *mainPageView;
@property (nonatomic,strong)MovieViewModel *movieViewModel;
@property (nonatomic,strong)MovieModel *movieModel;
- (void)initializeAppearance;
- (void)initilazeDataSoucre;
@end

@implementation AmuseViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"娱乐天地";
        self.view.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}
- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"movieListResponseObject"];
}
#pragma mark - getter

- (MovieViewModel *)movieViewModel {
    
    if (!_movieViewModel) {
        
        _movieViewModel = ({
            
            MovieViewModel *movieViewModel = [[MovieViewModel alloc] init];
            movieViewModel;
            
        });
    }
    return _movieViewModel;
}

- (MovieModel *)movieModel {
    
    if (!_movieModel) {
        
        _movieModel = ({
            
            MovieModel *movieModel = [[MovieModel alloc] init];
            movieModel;
            
        });
    }
    return _movieModel;
}

- (MainPageView *)mainPageView {
    
    if (!_mainPageView) {
        
        _mainPageView = ({
            
            MainPageView *view = [[MainPageView alloc] initWithFrame:self.view.bounds];
            view.delegate = self;
            view;
        });
    }
    return _mainPageView;
}

- (void)initilazeDataSoucre {
    
    [self.movieViewModel postMovieList];
    [self.movieViewModel addObserver:self forKeyPath:@"movieListResponseObject" options:NSKeyValueObservingOptionNew context:nil];
    [self.movieViewModel addObserver:self forKeyPath:@"movieInfoResponseObject" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)initializeAppearance {
    [self.view addSubview:self.mainPageView];
    
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"你的设备不能定位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [alert resignFirstResponder];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initilazeDataSoucre];
    [self initializeAppearance];
}

#pragma mark - kvo 

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqual:@"movieListResponseObject"]) {
        
        self.mainPageView.dataSource = self.movieViewModel.movieListResponseObject[@"result"];
        [self.mainPageView.topView reloadData];
    }else if ([keyPath isEqual:@"movieInfoResponseObject"]){
        
        self.mainPageView.ratingView.score = self.movieViewModel.movieInfoResponseObject[@"result"][@"rating"];
        self.mainPageView.actorsLabel.text = self.movieViewModel.movieInfoResponseObject[@"result"][@"actors"];
        CGSize actorsSize = [self.mainPageView sizeWithText:self.mainPageView.actorsLabel.text font:self.mainPageView.fontDic[@"actorsFont"] maxSize:CGSizeMake(CGRectGetWidth(self.mainPageView.bounds) - 10, MAXFLOAT)];
        self.mainPageView.actorsLabel.frame = CGRectMake(5, 0, actorsSize.width, actorsSize.height);
        self.mainPageView.introduceLabel.text = self.movieViewModel.movieInfoResponseObject[@"result"][@"plot_simple"];
        CGSize introduceSize = [self.mainPageView sizeWithText:self.mainPageView.introduceLabel.text font:self.mainPageView.fontDic[@"introduceFont"] maxSize:CGSizeMake(CGRectGetWidth(self.mainPageView.bounds) - 10, MAXFLOAT)];
        self.mainPageView.introduceLabel.frame = CGRectMake(5, CGRectGetMaxY(self.mainPageView.actorsLabel.frame)+ 10, introduceSize.width, introduceSize.height);
        self.mainPageView.detailView.frame = CGRectMake(0, CGRectGetMidY(self.mainPageView.bounds) + 130, CGRectGetWidth(self.mainPageView.bounds), CGRectGetMaxY(self.mainPageView.introduceLabel.frame));
        self.mainPageView.wholePageScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.mainPageView.bounds), CGRectGetMaxY(self.mainPageView.detailView.frame));
        
        }
}

#pragma mainPageView代理

- (void)movieInfoWithMovieId:(NSString *)movieId {
    
    [self.movieViewModel postMovieInfo:movieId];
}
- (void)mainPageViewDetialButtonPress:(UIButton *)sender movieName:(NSString *)movieName{
    
    DetailMovieViewController *detialVC = [[DetailMovieViewController alloc] initWithMovieName:movieName];
    [self.navigationController pushViewController:detialVC animated:YES];
    
}

- (void)mainPageViewWholePageDidScrollToContentOffset:(CGPoint)contentOffset {
    
    CGFloat offsetY = contentOffset.y;
    CGFloat alpha = offsetY / 64.0;
    if (alpha >= 0 && alpha <= 1) {
    }
}

- (void)mainPageViewCinameButtonPressWithCinemas:(NSArray *)cinemas {
    
    CinemasViewController *cinemaVC = [[CinemasViewController alloc] init];
    cinemaVC.dataSource = cinemas;
    [self.navigationController pushViewController:cinemaVC animated:YES];
}

@end
