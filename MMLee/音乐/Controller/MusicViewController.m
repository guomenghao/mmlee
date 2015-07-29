//
//  MusicViewController.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/21.
//  Copyright © 2015年 郭梦浩. All rights reserved.
//

#import "MusicViewController.h"
#import "SDCycleScrollView.h"
#import "MusicItemCollectionViewCell.h"
#import "MusicCollectionReusableView.h"
#import "MusicViewModel.h"
#import "PublicClass.h"
#import "MusicModel.h"
@interface MusicViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)MusicViewModel *newsMusicViewModel;
@property (nonatomic,strong)MusicViewModel *commendMusicViewModel;
@property (nonatomic,strong)MusicModel *musicModel;
- (void)initilazeDataSoucre;
- (void)initilazeApearance;
@end

@implementation MusicViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.title = @"音乐馆";
        
    }
    return self;
}
#pragma mark - 移除监听

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:@"MusicresponseObj"];
}

#pragma mark - getter方法

- (MusicViewModel *)commendMusicViewModel {
    
    if (!_commendMusicViewModel) {
        
        _commendMusicViewModel = ({
            
            MusicViewModel *musicViewModel = [[MusicViewModel alloc] init];
            musicViewModel;
        });
    }
    return _commendMusicViewModel;
}

- (MusicViewModel *)newsMusicViewModel {
    
    if (!_newsMusicViewModel) {
        
        _newsMusicViewModel = ({
            
            MusicViewModel *musicViewModel = [[MusicViewModel alloc] init];
            musicViewModel;
        });
    }
    return _newsMusicViewModel;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        _collectionView = ({
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake((self.view.bounds.size.width - 5) / 3.0, 160);
            layout.minimumLineSpacing = 10;
            layout.minimumInteritemSpacing = 0;
            //设置表头大小
            layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 30);
            
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 500) collectionViewLayout:layout];
            collectionView.backgroundColor = [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:238.0 / 255 alpha:1];
            collectionView.dataSource = self;
            collectionView.delegate = self;
            //注册cell
            [collectionView registerClass:[MusicItemCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
            //注册头部视图
            [collectionView registerClass:[MusicCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
            collectionView;
        });
        
        
    }
    return _collectionView;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = ({
            
            UIScrollView  *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
            scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 150);
            scrollView.scrollEnabled = YES;
            scrollView;
        });
        
    }
    return _scrollView;
}

- (SDCycleScrollView *)cycleScrollView {
    
    if (!_cycleScrollView) {
        
        _cycleScrollView = ({
            
            // 网络加载 --- 创建带标题的图片轮播器
            SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];
            cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            cycleScrollView.delegate = self;
            cycleScrollView.dotColor = [UIColor orangeColor]; // 自定义分页控件小圆标颜色
            cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
            cycleScrollView.autoScrollTimeInterval = 4.0;
            cycleScrollView;
        });
    }
    return _cycleScrollView;
}

- (void)myMusicListPanel {
    
    UIImageView *buttonBackImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 190, 365.0 / 375 * CGRectGetMaxX(self.view.bounds), 100)];
    buttonBackImage.layer.shadowRadius = 2.0;
    buttonBackImage.layer.shadowColor = [UIColor blackColor].CGColor;
    buttonBackImage.layer.shadowOffset = CGSizeMake(2, 0);
    buttonBackImage.layer.shadowOpacity = 0.3;
    buttonBackImage.backgroundColor = [UIColor whiteColor];
    buttonBackImage.userInteractionEnabled = YES;
    [_scrollView addSubview:buttonBackImage];
    NSArray *imageName = @[@"1-1_11",@"1-1_05",@"1-1_14",@"1-1_04-08"];
    NSArray *textName = @[@"最近播放",@"我的喜欢",@"全部歌曲",@"本地歌曲"];
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15.0 / 375 * CGRectGetMaxX(self.view.bounds) + 95 * i / AUTOLAYOUT_X, 16 / AUTOLAYOUT_Y, 58 / AUTOLAYOUT_X, 58 / AUTOLAYOUT_Y);
        [button setImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(musicListButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [buttonBackImage addSubview:button];
        
    }
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0 / 375 * CGRectGetMaxX(self.view.bounds) + 95 * i / AUTOLAYOUT_X, 76 / AUTOLAYOUT_Y, 63 / AUTOLAYOUT_X, 20 /AUTOLAYOUT_Y)];
        label.text = textName[i];
        label.textColor = [UIColor colorWithRed:234.0 / 225 green:87.0 / 225 blue:29.0 / 225 alpha:1];
        label.font = [UIFont systemFontOfSize:13];
        label.tag = 200 + i;
        [buttonBackImage addSubview:label];
    }
    
}

- (void)initilazeApearance {
    
    self.view.backgroundColor = [UIColor colorWithRed:238.0 / 255 green:238.0 / 255 blue:238.0 / 255 alpha:1];
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.cycleScrollView];
    [self myMusicListPanel];
    [_scrollView addSubview:self.collectionView];
}

- (void)initilazeDataSoucre {
    
    
    [self.newsMusicViewModel postMusicListResult:@"新歌" WithMusicType:@"1000"];
    [self.commendMusicViewModel postMusicListResult:@"推荐" WithMusicType:@"1000"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.newsMusicViewModel addObserver:self forKeyPath:@"MusicresponseObj" options:NSKeyValueObservingOptionNew context:nil];
    [self.commendMusicViewModel addObserver:self forKeyPath:@"MusicresponseObj" options:NSKeyValueObservingOptionNew context:nil];
    [self initilazeDataSoucre];
    [self initilazeApearance];
    // Do any additional setup after loading the view.
}


#pragma mark - 按钮事件
- (void)musicListButtonPress:(UIButton *)sender {
    
    
}

#pragma mark - 集合视图代理事件
//设置collectview的分组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}
//设置每个section中的cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}
//指定每个单元行返回什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        //从可重用的队列中去获取一个cell
        MusicItemCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        [cell updateMusicItemViewCell:[self.newsMusicViewModel cellInfoAtIndexPath:indexPath]];
        return cell;
    } else if (indexPath.section == 1) {
        
        //从可重用的队列中去获取一个cell
        MusicItemCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        [cell updateMusicItemViewCell:[self.commendMusicViewModel cellInfoAtIndexPath:indexPath]];
                return cell;
        
    }
    
    else {
        
        //从可重用的队列中去获取一个cell
        MusicItemCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        cell.label.text = @"无网络数据";
        return cell;
    }
}
//通过indexPath来指定header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [self collectionViewCellHead:@"最新歌单" collectionView:collectionView atIndexPath:indexPath];
    }else
        
        if (indexPath.section == 1) {
            return [self collectionViewCellHead:@"流行歌单" collectionView:collectionView atIndexPath:indexPath];
        } else{
            
            return [self collectionViewCellHead:@"推荐歌单" collectionView:collectionView atIndexPath:indexPath];
        }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.section == 0) {
//        
//        [self getMusicResult:((MusicListModel *)(_newMusicListDataSource[indexPath.row])).musicListId];
//        
//    }
//    if (indexPath.section == 1) {
//        
//        [self getMusicResult:((MusicListModel *)(_topMusicListDataSource[indexPath.row])).musicListId];
//    }
    
}

- (UICollectionReusableView *)collectionViewCellHead:(NSString *)title collectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    
    //从重用队列当中取出了补充视图，作为表头使用
    MusicCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    view.label.text = title;
    return view;
    
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"MusicresponseObj"]) {
        
        
        [self.collectionView reloadData];
        
    }
}
@end
