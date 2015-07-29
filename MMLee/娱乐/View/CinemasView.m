//
//  CinemasView.m
//  MMLee
//
//  Created by 郭梦浩 on 15/5/25.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "CinemasView.h"
#import "CinemaCell.h"
#import "CustomNavigationBar.h"
#import "CinemaFrame.h"
#import "AppDelegate.h"

@interface CinemasView ()<UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *_tableView;
    CustomNavigationBar *_cusNavigationBar;
}
@property (nonatomic, strong) NSArray *dataSource;


- (void)initializeAppearance;
- (void)initializeDataSource;
@end

@implementation CinemasView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        
        _dataSource = dataSource;
        [self initializeAppearance];
    }
    return self;
}

- (void)initializeDataSource {
    
    
}

- (void)initializeAppearance {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CinemaFrame *modelF = _dataSource[indexPath.row];
    return modelF.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"cel";
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CinemaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.modelF = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.delegate cinemasViewDidScorllToContentOffset:scrollView.contentOffset];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
