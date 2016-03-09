//
//  YMComment.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/9.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YMUser;

@interface YMComment : NSObject

/** 音频文件的时长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容*/
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量*/
@property (nonatomic, assign) NSInteger like_count;
/** 用户*/
@property (nonatomic, strong) YMUser *user;

@end
