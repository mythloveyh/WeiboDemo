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

@end
