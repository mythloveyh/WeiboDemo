//
//  ENHNewfeatureTool.m
//  SinaWeibo
//
//  Created by Digger on 15/10/26.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHNewfeatureTool.h"

@implementation ENHNewfeatureTool

+(void)newfeature{
    NSString* version = @"CFBundleVersion";
    NSString* lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:version];
    
    NSString* currentVersion = [NSBundle mainBundle].infoDictionary[version];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        window.rootViewController = [[ENHTabberViewController alloc] init];
    }else{
        window.rootViewController = [[ENHNewfeatureViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:version];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
