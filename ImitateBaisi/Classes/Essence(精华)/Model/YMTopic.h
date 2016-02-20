//
//  YMTopic.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/16.
//  Copyright © 2016年 hrscy. All rights reserved.
//  帖子

#import <UIKit/UIKit.h>

@interface YMTopic : NSObject

/** 名称*/
@property (nonatomic, copy) NSString *name;
/** 头像*/
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间*/
@property (nonatomic, copy) NSString *create_time;
/** 文字时间*/
@property (nonatomic, copy) NSString *text;
/** 踩的数量*/
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量*/
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量*/
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量*/
@property (nonatomic, assign) NSInteger comment;
/** 是否是新浪加v用户*/
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/** 图片的宽度*/
@property (nonatomic, assign) CGFloat width;
/** 图片的高度*/
@property (nonatomic, assign) CGFloat height;
/** 小图片路径*/
@property (nonatomic, copy) NSString *small_image;
/** 大图片路径*/
@property (nonatomic, copy) NSString *large_image;
/** 中图片路径*/
@property (nonatomic, copy) NSString *middle_image;

/******** 额外属性 *********/
/** cell的高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 帖子的类型*/
@property (nonatomic, assign) YMTopicType type;
/** 图片控件的frame*/
@property (nonatomic, assign, readonly) CGRect pictureF;

@end
