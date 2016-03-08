//
//  YMVoiceView.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/7.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMVoiceView.h"
#import "YMTopic.h"
#import "UIImageView+WebCache.h"

@interface YMVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@end

@implementation YMVoiceView

-(void)setTopic:(YMTopic *)topic {
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd", topic.playcount];
    //时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

+(instancetype)voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
