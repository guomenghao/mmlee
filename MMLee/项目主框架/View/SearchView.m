//
//  SearchView.m
//  MMLee
//
//  Created by 郭梦浩 on 15/7/22.
//  Copyright (c) 2015年 郭梦浩. All rights reserved.
//

#import "SearchView.h"
#import "PublicClass.h"
@interface SearchView ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *searchField;
@property(nonatomic,strong)UIButton *personIofo;
@property(nonatomic,strong)UIButton *weChat;
- (void)initializeApperance;
@end
@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        [self initializeApperance];
    }
    return self;
}

- (UITextField *)searchField {
    
    if (!_searchField) {
        
        _searchField = ({
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(77 / AUTOLAYOUT_X, 20 / AUTOLAYOUT_Y, 240 / AUTOLAYOUT_X, 35 / AUTOLAYOUT_Y)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.backgroundColor = [UIColor colorWithRed:212.0 / 255 green:45.0 / 255 blue:0 / 255.0 alpha:1];
            textField.delegate = self;
            textField.placeholder = @"搜索歌曲名";
            [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField;
        });
    }
    return _searchField;
}

- (UIButton *)weChat {
    
    if (!_weChat) {
        
        _weChat = ({
            
            UIButton *button =  [[UIButton alloc] initWithFrame:CGRectMake(20 / AUTOLAYOUT_X, 25 / AUTOLAYOUT_Y, 30 / AUTOLAYOUT_X, 30 / AUTOLAYOUT_Y)];
            [button setImage:[UIImage imageNamed:@"iconfont-gerenzhongxin"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(weChatButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _weChat;
}

- (UIButton *)personIofo {
    
    if (!_personIofo) {
        
        _personIofo = ({
            
            UIButton *button =  [[UIButton alloc] initWithFrame:CGRectMake((375.0 - 40) / AUTOLAYOUT_X, 25 / AUTOLAYOUT_Y, 30 / AUTOLAYOUT_X, 30 / AUTOLAYOUT_Y)];
            [button setImage:[UIImage imageNamed:@"iconfont-liaotianduihua"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(weChatButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _personIofo;
}

- (void)initializeApperance {
    
    [self addSubview:self.searchField];
    [self addSubview:self.weChat];
    [self addSubview:self.personIofo];
    
    
}

#pragma mark - 按键事件

- (void)weChatButtonPress:(UIButton *)sender {
    
    self.weChatBlock();
}

- (void)persionInfoButtonPress:(UIButton *)sender {
    
    self.personInfoBlock();
}
#pragma mark - textFileddelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.searchBlock();
    [self.searchField resignFirstResponder];
}
@end
