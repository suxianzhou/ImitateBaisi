//
//  YMPublishViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/27.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMPublishViewController.h"
#import "YMVerticalButton.h"
#import "POP.h"

static CGFloat const YMAnimationDelay = 0.1;
static CGFloat const YMAnimationSpringFactor = 8;

@interface YMPublishViewController ()
/** */
@property (nonatomic, copy) void (^completionBlock)();
@end

@implementation YMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //中间6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat butttonStartY = (SCREENH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 25;
    CGFloat xMargin = (SCREENW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < 6; i++) {
        YMVerticalButton *button = [[YMVerticalButton alloc] init];
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //计算X、Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = butttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - SCREENH;
        
        //添加动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        animation.springSpeed = YMAnimationSpringFactor;
        animation.springBounciness = YMAnimationSpringFactor;
        animation.beginTime = CACurrentMediaTime() + YMAnimationDelay * i;
        [button pop_addAnimation:animation forKey:nil];
    }
    
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = SCREENW * 0.5;
    CGFloat centerEndY = SCREENH * 0.2;
    CGFloat centerBeginY = centerEndY - SCREENH;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    animation.beginTime = CACurrentMediaTime() + YMAnimationDelay * images.count;
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
        //回复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:animation forKey:nil];
    
}

-(void)buttonClick:(UIButton *)button {
    
    [self cancelWithCompletionBlock:^(int a, int b) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
    
    
}

#pragma mark 先执行退出动画，动画完成后执行completionBlock
-(void)cancelWithCompletionBlock:(void(^)())completionBlock {
    
    self.view.userInteractionEnabled = NO;
    int beginIndex = 2;
    
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        //添加动画
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + SCREENH;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        animation.beginTime = CACurrentMediaTime() + YMAnimationDelay * (i - beginIndex);
        [subview pop_addAnimation:animation forKey:nil];
        
        //监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
                [self dismissViewControllerAnimated:NO completion:nil];
//                if (completionBlock) {
//                    completionBlock();
//                }
                !completionBlock ? : completionBlock();
            }];
        }
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelWithCompletionBlock:nil];
}

@end
