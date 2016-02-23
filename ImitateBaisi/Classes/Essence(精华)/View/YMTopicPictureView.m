//
//  YMTopicPictureView.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/20.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTopicPictureView.h"
#import "YMTopic.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"

@interface YMTopicPictureView ()
/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif图片*/
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图*/
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation YMTopicPictureView

-(void)awakeFromNib {
    
    //如果发现控件的位置和尺寸不是自己设置的，那么有可能是自动伸缩属性导致
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 2;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}

+(instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

-(void)setTopic:(YMTopic *)topic {
    _topic = topic;
    /**
     *  判断图片是否为gif图片
        取出图片的第一个字节，就可以判断出图片的真是类型。
     */
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress];
         self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    //判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    //是否显示按钮"点击查看全图"
    if (topic.isBigPicture) { //大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { //非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
