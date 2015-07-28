//
//  IMViewController.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/22.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "IMViewController.h"
#import "InfoTableViewCell.h"
@interface IMViewController ()<UITableViewDataSource,UITableViewDelegate>
- (IBAction)backButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControll;
@property (nonatomic,strong)UITableView *infoTableView;
@property (nonatomic,strong)UITableView *friendTableView;
@end

@implementation IMViewController

- (UITableView *)infoTableView {
    
    if (!_infoTableView) {
        
        _infoTableView = ({
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            [tableView registerNib:[UINib nibWithNibName:@"InfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"InfoTableViewCell"];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView;
        });
    }
    return _infoTableView;
}
- (UITableView *)friendTableView {
    
    if (!_friendTableView) {
        
        _friendTableView = ({
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView;
        });
    }
    return _friendTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_segmentControll addTarget:self action:@selector(segmentControllChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentControllChange:(UISegmentedControl *)sender {
    
    NSInteger segmentIndex = sender.selectedSegmentIndex;
    
    switch (segmentIndex) {
        case 0:
            
            break;
        case 1:
            
            break;
            
        default:
            break;
    }
}

- (IBAction)backButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 集合视图方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *infoIdentifier = @"InfoTableViewCell";
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoIdentifier];
    if (!cell) {
        
        UINib *nib = [UINib nibWithNibName:@"InfoTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:infoIdentifier];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:infoIdentifier];
//    [cell updateCellInfo:<#(NSDictionary *)#>];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
