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
@interface AmuseViewController ()<MainPageViewDelegate, UISearchResultsUpdating>
@property (nonatomic,strong)MainPageView *mainPageView;
- (void)initializeAppearance;
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

- (MainPageView *)mainPageView {
    
    if (!_mainPageView) {
        
        _mainPageView = ({
            
            MainPageView *view = [[MainPageView alloc] initWithFrame:self.view.bounds];
            _mainPageView.delegate = self;
            view;
        });
    }
    return _mainPageView;
}

- (void)initializeAppearance {
    [self.view addSubview:self.mainPageView];
    
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"那啥" message:@"你的设备不能定位" preferredStyle:UIAlertControllerStyleAlert];
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
    [self initializeAppearance];
}




@end
