//
//  YMTopicCell.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/16.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTopicCell.h"
#import "YMTopic.h"
#import "UIImageView+WebCache.h"


@interface YMTopicCell ()
/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 创建时间*/
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶按钮*/
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩按钮*/
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享按钮*/
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commentBuuton;
/** 新浪加v*/
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;

@end

@implementation YMTopicCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setTopic:(YMTopic *)topic {
    _topic = topic;
    
    self.sina_vImageView.hidden = !topic.sina_v;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    
    //设置按钮的文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentBuuton count:topic.comment placeholder:@"评论"];
}

-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame {
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
