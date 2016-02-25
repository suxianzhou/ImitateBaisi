//
//  YMShowPictureViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/24.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMShowPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "YMTopic.h"
#import "SVProgressHUD.h"

@interface YMShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation YMShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButton:)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //屏幕尺寸
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    //图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > screenH) {
        //图片显示高度超过一个屏幕,屏幕需要滚动查看
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(pictureW, pictureH);
        
    } else {
        self.imageView.size = CGSizeMake(pictureW, pictureH);
        self.imageView.centerY = screenH * 0.5;
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 返回按钮
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 保存按钮
- (IBAction)save:(UIButton *)sender {
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark 保存成功
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
    
}


@end
