//
//  MusicItemCollectionViewCell.h
//  生活应用
//
//  Created by guomenghao on 15/5/18.
//  Copyright (c) 2015年 guomenghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicItemCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)NSString *musicListId;
- (void)updateMusicItemViewCell:(NSDictionary *)Dic;
@end
