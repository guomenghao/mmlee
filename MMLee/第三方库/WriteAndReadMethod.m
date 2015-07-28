//
//  WriteAndReadMethod.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/26.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "WriteAndReadMethod.h"
#import "UserData.h"
@implementation WriteAndReadMethod
+ (void)writeMusicData:(id)dataModel {
    
    //文件操作
    NSFileManager *maneger = [NSFileManager defaultManager];
    //1.获取文件路径
    NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    plistPath = [plistPath stringByAppendingString:@"/MusicList.plist"];
    if (![maneger fileExistsAtPath:plistPath]){
        
        [maneger createFileAtPath:plistPath contents:nil attributes:nil];
    }
    
    
    //2.处理数据
    NSMutableArray *dataList = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:plistPath]];
    //归档 把自定义数据转换成data
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataModel];
    [dataList addObject:data];
    //3.将数据内容写入到文件
    [dataList writeToFile:plistPath atomically:YES];

}

+ (void)readMusicData {
    
    //1.获得plist文件路径
    NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    plistPath = [plistPath stringByAppendingPathComponent:@"MusicList.plist"];
    //2.读取路径下的内容
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    UserData *userData = [UserData shareInstance];
    userData.musicList = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i++) {
        
        [userData.musicList addObject:[NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)array[i]]];
        
    }
}
@end
