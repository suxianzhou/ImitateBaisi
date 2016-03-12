//
//  YMCommentViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/11.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMCommentViewController.h"
#import "YMTopicCell.h"
#import "YMTopic.h"

@interface YMCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/** 工具条底部间距*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YMCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
}


-(void)setupHeader {
    YMTopicCell *cell = [YMTopicCell cell];
    cell.topic = self.topic;;
    cell.height = self.topic.cellHeight;
    self.tableView.tableHeaderView = cell;
}

-(void)setupBasic {
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)keyboardWillChangeFrame:(NSNotification *)notification {
    //键盘显示/隐藏完毕的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = SCREENH - frame.origin.y;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
