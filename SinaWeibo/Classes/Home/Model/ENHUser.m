//
//  ENHUser.m
//  SinaWeibo
//
//  Created by Digger on 16/1/11.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import "ENHUser.h"

@implementation ENHUser

+ (instancetype)userInitWithDict:(NSDictionary*) dict{
    ENHUser* user = [ENHUser new];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    user.mbtype = [dict[@"mbtype"] intValue];
    user.mbrank = [dict[@"mbrank"] intValue];
    return user;
}

-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    if (_mbtype > 2) {
        self.vip = YES;
    }
}

@end
