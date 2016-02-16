//
//  YMEssenceViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/12.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMEssenceViewController.h"
#import "YMRecommandTagsViewController.h"
#import "YMAllViewController.h"
#import "YMViedoViewController.h"
#import "YMVoiceViewController.h"
#import "YMPictureTableViewController.h"
#import "YMWordTableViewController.h"

@interface YMEssenceViewController () <UIScrollViewDelegate>

/** 标签栏底部指示器*/
@property (nonatomic, weak) UIView *indicatorView;

/** 当前选中的按钮*/
@property (nonatomic, weak) UIButton *selectedButton;

/** 顶部的标签*/
@property (nonatomic, weak) UIView *titlesView;
/** UIScrollView*/
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation YMEssenceViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控制器
    [self setupChildViewControllers];
    //设置导航栏
    [self setupNav];
    //设置顶部标签栏
    [self setupTitlesView];
    //底部的scrollview
    [self setupContentView];
}

#pragma mark  初始化子控制器
-(void)setupChildViewControllers {
    YMAllViewController *allVC = [[YMAllViewController alloc] init];
    [self addChildViewController:allVC];
    YMViedoViewController *videoVC = [[YMViedoViewController alloc] init];
    [self addChildViewController:videoVC];
    YMVoiceViewController *voiceVC = [[YMVoiceViewController alloc] init];
    [self addChildViewController:voiceVC];
    YMPictureTableViewController *pictureVC = [[YMPictureTableViewController alloc] init];
    [self addChildViewController:pictureVC];
    YMWordTableViewController *wordVC = [[YMWordTableViewController alloc] init];
    [self addChildViewController:wordVC];
}

#pragma mark 底部的scrollview
-(void)setupContentView {
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark 设置顶部标签栏
-(void)setupTitlesView {
    //标签栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    titlesView.frame = CGRectMake(0, 64, self.view.width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    //内部子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = 5;
    CGFloat width = titlesView.width / count;
    CGFloat height = titlesView.height;
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * width;
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            //让按钮内部的Label根据文字来计算内容
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

#pragma mark 便签栏按钮点击
-(void)titleClick:(UIButton *)button {
    //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    //让标签执行动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = self.selectedButton.titleLabel.width;
        self.indicatorView.centerX = self.selectedButton.centerX;
    }];
    //滚动,切换子控制器
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark 设置导航栏
-(void)setupNav {
    self.view.backgroundColor = YMGlobalBg;
    //设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagButtonClick)];
}

#pragma mark 导航栏左边的按钮点击
-(void)tagButtonClick {
    YMRecommandTagsViewController *tagVC = [[YMRecommandTagsViewController alloc] init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加子控制器的view
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //点击button
    [self titleClick:self.titlesView.subviews[index]];
}

@end
