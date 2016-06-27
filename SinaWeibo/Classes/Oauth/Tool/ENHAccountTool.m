//
//  ENHAccountTool.m
//  SinaWeibo
//
//  Created by Digger on 15/10/26.
//  Copyright © 2015年 Digger. All rights reserved.
//

#define ENHAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archiver"]

#import "ENHAccountTool.h"

@implementation ENHAccountTool

+(void)saveAccount:(ENHAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:ENHAccountPath];
}

+(ENHAccount *)account{
    ENHAccount* account = [NSKeyedUnarchiver unarchiveObjectWithFile:ENHAccountPath];
    
    //验证账号是否过期
    long long expires_in = [account.expires_in longLongValue];
    NSDate* expiresTime = [account.create_time dateByAddingTimeInterval:expires_in];
    NSDate* now = [NSDate date];
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}

@end
