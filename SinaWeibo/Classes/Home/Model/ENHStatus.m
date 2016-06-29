//
//  ENHStatus.m
//  SinaWeibo
//
//  Created by Digger on 16/1/11.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import "MJExtension.h"
#import "ENHStatus.h"
#import "ENHUser.h"
#import "ENHStatusPhoto.h"

@implementation ENHStatus

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls":[ENHStatusPhoto class]};
}

+ (instancetype)statusInitWithDict:(NSDictionary*) dict{
    ENHStatus* status = [ENHStatus new];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    ENHUser* user = [ENHUser userInitWithDict:dict[@"user"]];
    status.user = user;
    status.created_at = dict[@"created_at"];
    status.source = dict[@"source"];
    status.pic_urls = dict[@"pic_urls"];
    NSDictionary* retweetStatus = dict[@"retweeted_status"];
    if (retweetStatus) {
         status.retweeted_status = retweetStatus;
    }
    return status;
}

-(BOOL)isHavePics{
    if (_pic_urls.count > 0) {
        return YES;
    }
    return NO;
}

- (NSString *)created_at{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate* date = [fmt dateFromString:_created_at];
    NSDate* now = [NSDate date];
    NSCalendar* calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour  | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents* components = [calender components:unit fromDate:date toDate:now options:0];
    NSDateComponents* currentComponents = [calender components:unit fromDate:now];
    NSDateComponents* componentsDate = [calender components:unit fromDate:date];
    if (currentComponents.year == componentsDate.year) {
        if (components.month > 0){
            return [NSString stringWithFormat:@"%ld月前",components.month];
        }
        if (components.day > 0){
            return [NSString stringWithFormat:@"%ld天前",components.day];
        }
        if (components.hour > 0){
            return [NSString stringWithFormat:@"%ld小时前",components.hour];
        }
        if (components.minute > 0){
            return [NSString stringWithFormat:@"%ld分钟前",components.minute];
        }
        if (components.second > 0){
            return [NSString stringWithFormat:@"%ld秒前",components.second];
        }
    }
    if (currentComponents.year > componentsDate.year) {
        return [NSString stringWithFormat:@"%ld年前",(currentComponents.year - components.year)];
    }
    return _created_at;
}

@end
