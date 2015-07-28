//
//  SearchListView.h
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SearchResultBlock)();
@protocol SearchListViewDelegate <NSObject>
- (NSInteger)searchListTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)searchListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)searchListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@optional

@end
@interface SearchListView : UIView
@property (nonatomic,strong)SearchResultBlock searchResultBlock;
@property (nonatomic,strong)UITextField *searchField;
@property (nonatomic,strong)UITableView *searchTableView;
@property (nonatomic,strong)NSMutableArray *musicListDataSource;
@property (nonatomic,strong)id<SearchListViewDelegate> SearchListViewDelegate;
@end
