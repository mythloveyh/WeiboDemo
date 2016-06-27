//
//  UIWindow+ENHUIWindow.m
//  SinaWeibo
//
//  Created by Digger on 15/11/7.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "ENHTabberViewController.h"
@implementation UIWindow (Extension)

- (void)switchRootController{
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    currentWindow.rootViewController = [[ENHTabberViewController alloc] init];
}

@end
