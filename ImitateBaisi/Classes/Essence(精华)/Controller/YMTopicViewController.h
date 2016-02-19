//
//  YMTopicViewController.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/19.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YMTopicTypeAll = 1,
    YMTopicTypePicture = 10,
    YMTopicTypeWord = 29,
    YMTopicTypeVoice = 31,
    YMTopicTypeVideo = 41,
}YMTopicType;

@interface YMTopicViewController : UITableViewController
/** 帖子的类型*/
@property (nonatomic, assign) YMTopicType type;
@end
