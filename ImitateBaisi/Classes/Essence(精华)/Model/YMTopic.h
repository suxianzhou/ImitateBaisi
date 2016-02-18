//
//  YMTopic.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/16.
//  Copyright © 2016年 hrscy. All rights reserved.
//  帖子

#import <Foundation/Foundation.h>

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

@end
