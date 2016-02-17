//
//  YMTopic.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/16.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTopic.h"
#import "NSDate+YMExtension.h"

@implementation YMTopic

-(NSString *)create_time  {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //创建时间
    NSDate  *createDate = [fmt dateFromString:_create_time];
    //当前时间
    NSDate *now = [NSDate date];
    
    //日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calender components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { //今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) {
            if (comps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)comps.hour];
            } else if (comps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)comps.minute];
            } else {
                return @"刚刚";
            }
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { //不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [fmt stringFromDate:createDate];
    }
}

@end
