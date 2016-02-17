//
//  YMVideoViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/15.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMViedoViewController.h"

@interface YMViedoViewController ()

@end

@implementation YMViedoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark 初始化表格
-(void)setupTableView {
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = YMTitlesViewY + YMTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd",[self class], indexPath.row];
    
    return cell;
}
@end
