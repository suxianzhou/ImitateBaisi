//
//  YMRecommandCategory.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/13.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMRecommandCategory.h"

@implementation YMRecommandCategory

-(NSMutableArray *)users{
    if (_users == nil) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

@end
