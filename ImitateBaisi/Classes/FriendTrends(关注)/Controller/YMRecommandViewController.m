//
//  YMRecommandViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/12.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMRecommandViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface YMRecommandViewController ()

@end

@implementation YMRecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = YMGlobalBg;
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //请求数据
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        YMLog(@"%@",responseObject);
        //隐藏指示器
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
