//
//  DetailMovieViewController.m
//  MMLee
//
//  Created by 郭梦浩 on 15/5/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "DetailMovieViewController.h"
#import "DetialMovieView.h"
#import "CustomNavigationBar.h"
#import "UMSocial.h"
#import "MovieViewModel.h"
#import "PublicClass.h"

@interface DetailMovieViewController ()<DetailMovieViewDelegate, UMSocialUIDelegate> {
    
    NSString *_moveName;
    DetialMovieView *_movieView;
    CustomNavigationBar *_cusNavigationBar;

}

@property (nonatomic,strong)MovieViewModel *movieViewModel;
- (void)initializeDataSource;
- (void)initializeAppearance;
- (void)backButtonPress:(UIButton *)sender;

@end

@implementation DetailMovieViewController

- (instancetype)initWithMovieName:(NSString *)movieName
{
    self = [super init];
    if (self) {
        _moveName = [movieName copy];
    }
    return self;
}
- (void)dissDealloc {
    
    [self.movieViewModel removeObserver:self forKeyPath:@"movieWithNameResponseObject"];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (MovieViewModel *)movieViewModel {
    
    if (!_movieViewModel) {
        
        _movieViewModel = ({
            
            MovieViewModel *movieViewModel = [[MovieViewModel alloc] init];
            movieViewModel;
        });
    }
    return _movieViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeAppearance];
}

- (void)initializeDataSource {
    
    [self.movieViewModel postMovieInfoWith:_moveName];
    [self.movieViewModel addObserver:self forKeyPath:@"movieWithNameResponseObject" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)initializeAppearance {
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect navigationBarRect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.hidden = YES;
    _cusNavigationBar = ({
        
        CustomNavigationBar *cusNavigationBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 45 / AUTOLAYOUT_Y, navigationBarRect.size.width, CGRectGetMaxY(navigationBarRect))];
        cusNavigationBar.backgroundColor = [[UIColor alloc] initWithRed:30 / 255.0 green:172 / 255.0 blue:245 / 255.0 alpha:1];
        cusNavigationBar.backgroundAlpha = 0;
        cusNavigationBar;
        
    });
    
    [_cusNavigationBar.leftBarButton setTitle:@"返回" forState:UIControlStateNormal];
    [_cusNavigationBar.leftBarButton addTarget:self action:@selector(backButtonPress:) forControlEvents:UIControlEventTouchUpInside];

    _movieView = [[DetialMovieView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) MoveName:_moveName];
    _movieView.delegate = self;
    [self.view addSubview:_movieView];
    
    [self.navigationController.topViewController.view addSubview:_cusNavigationBar];
    
}

#pragma mark - <DetailMovieViewDelegate>

- (void)detialmovieViewDidScrollContentOffset:(CGPoint)contentOffset {
    
    CGFloat offsetY = contentOffset.y;
    CGFloat alpha = offsetY / 64.0;
    if (alpha >= 0 && alpha <= 1) {
        _cusNavigationBar.backgroundAlpha = alpha;
    }
}

- (void)detialMovieViewShareButtonPress:(UIButton *)sender {
    
    UIAlertController *alertC =[UIAlertController alertControllerWithTitle:@"约吗" message:[NSString stringWithFormat:@"新电影《%@》上映了，我想去看看，有空的小伙伴请联系我！", _moveName] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"分享到微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [UMSocialSnsService presentSnsController:self
                                          appKey:nil
                                       shareText:[NSString stringWithFormat:@"新电影《%@》上映了，我想去看看，有空的小伙伴请联系我！", _moveName]
                                      shareImage:nil
                                 shareToSnsNames:@[UMShareToSina, UMShareToTencent]
                                        delegate:self];

    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我们不约" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertC resignFirstResponder];
    }];
    [alertC addAction:confirm];
    [alertC addAction:cancel];
    [self presentViewController:alertC animated:YES completion:nil];
    
    
    
}

#pragma mark - <UMSocialUIDelegate>

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    
    [_movieView showDatingImageView];
}


#pragma mark - event

- (void)backButtonPress:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dissDealloc];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqual:@"movieWithNameResponseObject"]) {
        
        [_movieView loadDetailDataSourceWith:self.movieViewModel.movieWithNameResponseObject[@"result"][0]];
    }
}

@end
