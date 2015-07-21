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
@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    
    NSInteger _currentIndex;
    NSInteger _selectBarIndex;
    CGFloat _currentSetOffX;
}
@property (nonatomic,strong)UICollectionView *barCollectionView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIView *selectedBarView;
- (void)initilazeDataSoucre;
- (void)initilazeApearance;
@end

@implementation MainViewController

- (UIView *)selectedBarView {
    
    if (!_selectedBarView) {
        _selectedBarView = ({
            UIView *selectedBarView = [[UIView alloc] initWithFrame:CGRectMake(14, 45, 60, 5)];
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
            layout.itemSize = CGSizeMake(80, 50);
            layout.minimumInteritemSpacing = 20;
            [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//            [layout setSectionInset:UIEdgeInsetsMake(0, 35, 0, 35)];
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50) collectionViewLayout:layout];
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
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
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

- (void)initilazeApearance {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = AppColor;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.barCollectionView];
    [self.view addSubview:self.selectedBarView];

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
            [_selectedBarView setFrame:CGRectMake(40 + indexPage * (barViewFrame.size.width + 20) , barViewFrame.origin.y, barViewFrame.size.width, barViewFrame.size.height)];
            _currentSetOffX = self.view.bounds.size.width * _currentIndex;
        }];
        
    }
    
}
@end
