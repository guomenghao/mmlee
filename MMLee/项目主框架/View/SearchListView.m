//
//  SearchListView.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "SearchListView.h"
#import "PublicClass.h"
#import "MusicModel.h"
#import "MusicInfoModel.h"
#import "UIImageView+WebCache.h"
@interface SearchListView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIVisualEffectView *visualEfView;

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIButton *cannelButton;

- (void)initializeApperance;
@end
@implementation SearchListView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self initializeApperance];
    }
    return self;
}

- (UIVisualEffectView *)visualEfView {
    
    if (!_visualEfView) {
        
        _visualEfView = ({
            
            UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
            visualEfView.frame = [UIScreen mainScreen].bounds;
            visualEfView;
        });
        
    }
    return  _visualEfView;
}

- (UIView *)topView {
    
    if (!_topView) {
        
        _topView = ({
            
            UIView *view = [[UIView alloc]init];
            view.frame = CGRectMake(0, -64, AUTOLAYOUT_SIZE.width, 64);
            view.backgroundColor = AppColor;
            view;
        });

    }
    return _topView;
}

- (UITextField *)searchField {
    
    if (!_searchField) {
        
        _searchField = ({
            
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 24, AUTOLAYOUT_SIZE.width-70, 30)];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.placeholder = @"搜索:歌曲名字";
            UIView * views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            UIImageView * imv = [[UIImageView alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
            imv.image = [UIImage imageNamed:@"19.2.png"];
            [views addSubview:imv];
            textField.leftView = imv;
            textField.leftViewMode = UITextFieldViewModeAlways;
            textField.font = [UIFont systemFontOfSize:14];
            textField.delegate = self;
            textField.returnKeyType = UIReturnKeySearch;
            textField;
        });
    }
    return _searchField;
}

- (UIButton *)cannelButton {
    
    if (!_cannelButton) {
        
        _cannelButton = ({
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(320 / AUTOLAYOUT_X, 30 / AUTOLAYOUT_Y, 50 / AUTOLAYOUT_X, 24 / AUTOLAYOUT_Y);
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(cannelButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _cannelButton;
}


- (UITableView *)searchTableView {
    
    if (!_searchTableView) {
        
        _searchTableView = ({
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, CGRectGetMaxX(self.bounds), 800) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            
            tableView.backgroundColor = [UIColor clearColor];
            tableView;
        });
    }
    return _searchTableView;
}

- (NSMutableArray *)musicListDataSource {
    
    if (!_musicListDataSource) {
        
        _musicListDataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _musicListDataSource;
}

- (void)initializeApperance {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.visualEfView];
    [self addSubview:self.topView];
    [self.topView addSubview:self.searchField];
    [self.topView addSubview:self.cannelButton];
    [self addSubview:self.searchTableView];
    [UIView animateWithDuration:0.5 animations:^{
        
        _topView.frame = CGRectMake(0, 0, AUTOLAYOUT_SIZE.width, 64);
        //            _visualEfView.alpha = 1;
    }];
    
}

- (void)cannelButtonPress:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _topView.frame = CGRectMake(0, -64, AUTOLAYOUT_SIZE.width, 64);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.returnKeyType == UIReturnKeySearch) {
        
        self.searchResultBlock();
        
    }
    return YES;
}
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.SearchListViewDelegate searchListTableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.SearchListViewDelegate searchListTableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.SearchListViewDelegate searchListTableView:tableView didSelectRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.5 animations:^{
        
        _topView.frame = CGRectMake(0, -64, AUTOLAYOUT_SIZE.width, 64);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
