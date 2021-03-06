//
//  SXReplyViewController.m
//  MMLee
//
//  Created by 郭梦浩 on 15/2/8.
//  Copyright (c) 2015年. All rights reserved.
//

#import "NewsReplyViewController.h"
#import "NewsReplyHeader.h"
#import "NewsReplyCell.h"

@interface NewsReplyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end


@implementation NewsReplyViewController
static NSString *ID = @"replyCell";

#pragma mark - ******************** 返回按钮
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad{
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - ******************** tbv数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (self.replys.count == 0) {
        return 1;
    }
    
    if (section == 0) {
        return self.replys.count;
    }else{
        return self.replys.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    
     NewsReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
       cell = [[NewsReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.replys.count == 0) {
        UITableViewCell *cell2 = [[UITableViewCell alloc]init];
        cell2.textLabel.text = @"     暂无跟帖数据";
        return cell2;
    }else{
        NewsReplyModel *model = self.replys[indexPath.row];
        cell.replyModel = model;
    }
    
    return cell;
}
/** 返回一个view来当tbv的header */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [NewsReplyHeader replyViewFirst];
    }else{
        return [NewsReplyHeader replyViewLast];
    }
}

/** 通过提前计算来返回行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.replys.count == 0){
        return 40;
    }else{
        NewsReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        NewsReplyModel *model = self.replys[indexPath.row];
        
        cell.replyModel = model;
        
        [cell layoutIfNeeded];
        CGSize size = [cell.sayLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return cell.sayLabel.frame.origin.y + size.height + 10;
    }
}

/** 预估行高，这个方法可以减少上面方法的调用次数，提高性能 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}
@end
