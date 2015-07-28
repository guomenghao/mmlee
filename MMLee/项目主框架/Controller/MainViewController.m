//
//  MainViewController.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/21.
//  Copyright © 2015年 郭梦浩. All rights reserved.
//

#import "MainViewController.h"
#import "PublicClass.h"
#import "CustomCollectionViewCell.h"
#import "SearchView.h"
#import "IMViewController.h"
#import "MusicPlayView.h"
#import "SearchListView.h"
#import "MusicViewModel.h"
#import "MusicInfoViewModel.h"
#import "MusicInfoModel.h"
#import "MusicSearchTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UserData.h"
#import "WriteAndReadMethod.h"
@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SearchListViewDelegate> {
    
    NSInteger _currentIndex;
    NSInteger _selectBarIndex;
    CGFloat _currentSetOffX;
}
@property (nonatomic,strong)UICollectionView *barCollectionView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIView *selectedBarView;
@property (nonatomic,strong)UIView *barView;
@property (nonatomic,strong)SearchView *searchView;
@property (nonatomic,strong)SearchListView *searchListView;
@property (nonatomic,strong)MusicPlayView *musicPlayView;
@property (nonatomic,strong)MusicInfoViewModel *musicViewModel;
- (void)initilazeDataSoucre;
- (void)initilazeApearance;
@end

@implementation MainViewController

- (MusicPlayView *)musicPlayView {
    
    if (!_musicPlayView) {
        
        _musicPlayView = ({
            
            MusicPlayView *musicPlayView = [[MusicPlayView alloc] initWithFrame:CGRectMake(0, (667 - 60) / AUTOLAYOUT_Y, WIDTH, 60 / AUTOLAYOUT_Y)];
            musicPlayView;
        });
    }
    return _musicPlayView;
}

- (UIView *)barView {
    
    if (!_barView) {
        _barView = ({
            
            UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375 / AUTOLAYOUT_X, 65 / AUTOLAYOUT_Y)];
            barView.backgroundColor = AppColor;
            barView;
        });
    }
    return _barView;
}

- (SearchView *)searchView {
    
    if (!_searchView) {
        _searchView = ({
            
            SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, 375 / AUTOLAYOUT_X, 60 / AUTOLAYOUT_Y)];
            searchView;
        });
    }
    return _searchView;
}

- (UIView *)selectedBarView {
    
    if (!_selectedBarView) {
        _selectedBarView = ({
            UIView *selectedBarView = [[UIView alloc] initWithFrame:CGRectMake(14 / AUTOLAYOUT_X, 110 / AUTOLAYOUT_Y, 60 / AUTOLAYOUT_X, 5 / AUTOLAYOUT_Y)];
            selectedBarView.backgroundColor = [UIColor orangeColor];
            selectedBarView;
            
        });
    }
    return _selectedBarView;
}


- (UICollectionView *)barCollectionView {
    
    if (!_barCollectionView) {
        _barCollectionView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake(80 / AUTOLAYOUT_X, 50 / AUTOLAYOUT_Y);
            layout.minimumInteritemSpacing = 20;
            [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//            [layout setSectionInset:UIEdgeInsetsMake(0, 35, 0, 35)];
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 65 / AUTOLAYOUT_Y, self.view.bounds.size.width, 50 / AUTOLAYOUT_Y) collectionViewLayout:layout];
            collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            
            [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
            collectionView;
            
        });
}
    return _barCollectionView;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = ({
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65 / AUTOLAYOUT_Y, self.view.bounds.size.width, self.view.bounds.size.height - 50 / AUTOLAYOUT_Y)];
            scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.childControllers.count, 0);
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.scrollsToTop = NO;
            scrollView.scrollEnabled = YES;
            scrollView.pagingEnabled = YES;
            scrollView.delegate = self;
            for (NSInteger i = 0 ; i < self.childControllers.count; i++) {
                
                ((UIViewController *)(self.childControllers[i])).view.frame = CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, scrollView.bounds.size.height);
                [scrollView addSubview:((UIViewController *)(self.childControllers[i])).view];
                [self addChildViewController:((UIViewController *)(self.childControllers[i]))];
            }
            scrollView;
            
        });
    }
    return _scrollView;
}

- (MusicInfoViewModel *)musicViewModel {
    
    if (!_musicViewModel) {
        
        _musicViewModel = ({
            
            MusicInfoViewModel *musicViewModel = [[MusicInfoViewModel alloc] init];
            musicViewModel;
        });
    }
    return _musicViewModel;
}


- (void)initilazeApearance {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.barView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.barCollectionView];
    [self.view addSubview:self.selectedBarView];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.musicPlayView];
    __weak typeof(self) safeSelf = self;
    _searchView.weChatBlock = ^(){
        
        [safeSelf presentViewController:[[IMViewController alloc] initWithNibName:@"IMViewController" bundle:nil] animated:YES completion:nil];
    };
    _searchView.searchBlock = ^(){
        
        SearchListView *searchListView = [[SearchListView alloc] initWithFrame:CGRectMake(0, 0, AUTOLAYOUT_SIZE.width, AUTOLAYOUT_SIZE.height)];
        _searchListView = searchListView;
        searchListView.SearchListViewDelegate = safeSelf;
        [safeSelf.view addSubview:searchListView];
        __weak typeof(searchListView) safeSearchListView = searchListView;
        searchListView.searchResultBlock = ^(){
            
            [safeSelf.musicViewModel postSearchMusic:safeSearchListView.searchField.text];
        };
    };
    [self.musicViewModel addObserver:self forKeyPath:@"MusicSearchPonseObj" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)initilazeDataSoucre {
    
    _currentIndex = 0;
    _currentSetOffX = 0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initilazeDataSoucre];
    [self initilazeApearance];
}



#pragma mark - 集合视图的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return (self.childControllers).count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *title = ((UIViewController *)(((UINavigationController *)(self.childControllers[indexPath.row])).viewControllers[0])).title;
    Cell.title.text = title;
    return Cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = _selectedBarView.frame;
        frame.origin.x = Cell.frame.origin.x;
        [_selectedBarView setFrame:frame];
    }];
    [self moveToViewControllerAtIndex:indexPath.row];
    _currentIndex = indexPath.row;
    Cell.title.textColor = [UIColor orangeColor];
    [_barCollectionView reloadData];
}

#pragma mark - search代理方法

- (NSInteger)searchListTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.musicViewModel.MusicSearchPonseObj.count;
}

- (UITableViewCell *)searchListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ArtCellIdentifier = @"MusicSearchCell";
    MusicSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ArtCellIdentifier];
    if (!cell) {
        
        UINib *nib = [UINib nibWithNibName:@"MusicSearchTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ArtCellIdentifier];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:ArtCellIdentifier];
    MusicInfoModel *musicModel = [self.musicViewModel.MusicSearchPonseObj objectAtIndex:[indexPath row]];
    [cell.MusicAlbumImageView sd_setImageWithURL:[NSURL URLWithString:musicModel.musicImage]];
    cell.MusicName.text = musicModel.musicTitle;
    cell.MusicArtist.text = musicModel.musicArtist;
    cell.MusicAlbum.text = musicModel.musicAlbum;
    cell.backgroundColor = [UIColor clearColor];
    return cell;

}

- (void)searchListTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicInfoModel *musicModel = [self.musicViewModel.MusicSearchPonseObj objectAtIndex:[indexPath row]];
    UserData *userData = [UserData shareInstance];
    userData.musicInfoModel = musicModel;
    [WriteAndReadMethod writeMusicData:musicModel];
    [self.musicPlayView updateMusicPlane];
    
}

#pragma mark - 移动控制器的方法（点击，手势）
- (void)moveToViewControllerAtIndex:(NSInteger)index {
    
    NSInteger contentOffSetIndex = index - _currentIndex;
    if (![self isViewLoaded]) {
        
        _currentIndex = index;
        
    }else {
        
        if(ABS(_currentIndex - index) > 0) {
            
            if (_currentIndex > index) {
                _currentSetOffX = _currentSetOffX + contentOffSetIndex * CGRectGetWidth(self.view.bounds);
                [_scrollView setContentOffset:CGPointMake(_currentSetOffX, 0) animated:YES];
            }else if((_currentIndex - index) < 0) {
                _currentSetOffX = _currentSetOffX +contentOffSetIndex * CGRectGetWidth(self.view.bounds);
                [_scrollView setContentOffset:CGPointMake(_currentSetOffX, 0) animated:YES];
            }
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentSetFloat =  (self.childControllers.count - 1) * self.view.bounds.size.width;
    if (scrollView.contentOffset.x - contentSetFloat <= 0) {
        
        NSInteger indexPage = scrollView.contentOffset.x / self.view.bounds.size.width;
        _currentIndex = indexPage;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect barViewFrame = _selectedBarView.frame;
            [_selectedBarView setFrame:CGRectMake(40 / AUTOLAYOUT_X + indexPage * (barViewFrame.size.width + 20 / AUTOLAYOUT_X) , barViewFrame.origin.y, barViewFrame.size.width, barViewFrame.size.height)];
            _currentSetOffX = self.view.bounds.size.width * _currentIndex;
        }];
        
    }
    
}
#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqual:@"MusicSearchPonseObj"]) {
        
        _searchListView.musicListDataSource = self.musicViewModel.MusicSearchPonseObj;
        
        [_searchListView.searchTableView reloadData];
    }
}
@end
