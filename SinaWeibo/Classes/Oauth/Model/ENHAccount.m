//
//  ENHAccount.m
//  SinaWeibo
//
//  Created by Digger on 15/10/26.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHAccount.h"

@interface ENHAccount()<NSCoding>

@end

@implementation ENHAccount

+(instancetype)accountWithDict:(NSDictionary *)dict{
    ENHAccount* account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.remind_in = dict[@"remind_in"];
    account.uid = dict[@"uid"];
    //获取产生时间
    NSDate* createTime = [NSDate date];
    account.create_time = createTime;
    return account;
}

-(void)encodeWithCoder:(NSCoder *)encode{
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeObject:self.expires_in forKey:@"expires_in"];
    [encode encodeObject:self.remind_in forKey:@"remind_in"];
    [encode encodeObject:self.uid forKey:@"uid"];
    [encode encodeObject:self.create_time forKey:@"create_time"];
    [encode encodeObject:self.name forKey:@"name"];
}

-(instancetype)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.create_time = [decoder decodeObjectForKey:@"create_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
