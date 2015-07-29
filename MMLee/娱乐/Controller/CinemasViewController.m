//
//  CinemasViewController.m
//  MMLee
//
//  Created by 郭梦浩 on 15/5/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "CinemasViewController.h"
#import "CinemasView.h"
#import "CustomNavigationBar.h"


@interface CinemasViewController ()<cinemasViewDelegate> {
    
    CustomNavigationBar *_cusNavigationBar;

}

@property (nonatomic, strong) CinemasView *cinemasV;

- (void)initializeAppearance;
- (void)initializeDataSource;
- (void)backButtonPress:(UIButton *)sender;


@end

@implementation CinemasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeAppearance];
    
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    
   return UIStatusBarStyleLightContent;
}


- (void)initializeDataSource {
    
    
}


- (void)initializeAppearance {
    
    self.navigationController.navigationBar.hidden = YES;
    _cusNavigationBar = ({
        
        CustomNavigationBar *bar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
        bar.backgroundColor = [[UIColor alloc] initWithRed:30 / 255.0 green:172 / 255.0 blue:245 / 255.0 alpha:1];
        bar.backgroundAlpha = 1;
        bar.title = @"附近的电影院";
        bar;
    });
    
    [_cusNavigationBar.leftBarButton setTitle:@"< 返回" forState:UIControlStateNormal];
    [_cusNavigationBar.leftBarButton addTarget:self action:@selector(backButtonPress:) forControlEvents:UIControlEventTouchUpInside];

    _cinemasV = [[CinemasView alloc] initWithFrame:self.view.bounds dataSource:_dataSource];
    _cinemasV.delegate = self;
    [self.view addSubview:_cinemasV];
    
    [self.navigationController.topViewController.view addSubview:_cusNavigationBar];

}

#pragma mark - <cinemasViewDelegate>

- (void)cinemasViewDidScorllToContentOffset:(CGPoint)contentOffset {
    
    CGFloat offsetY = contentOffset.y;
    CGFloat alpha = offsetY / 64.0;
    if (alpha >= 0 && alpha <= 1) {
        _cusNavigationBar.backgroundAlpha = 1 - alpha;
    }
    
}

#pragma mark - event

- (void)backButtonPress:(UIButton *)sender  {
    
    [self.navigationController popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
