//
//  MusicSearchTableViewCell.h
//  亲密互动
//
//  Created by 郭梦浩 on 15/5/24.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicSearchTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *MusicAlbumImageView;
@property (strong, nonatomic) IBOutlet UILabel *MusicName;
@property (strong, nonatomic) IBOutlet UILabel *MusicArtist;
@property (strong, nonatomic) IBOutlet UILabel *MusicAlbum;

@end
