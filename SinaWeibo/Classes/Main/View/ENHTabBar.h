//
//  ENHTabBar.h
//  SinaWeibo
//
//  Created by Digger on 15/10/21.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ENHTabBar;

@protocol ENHTabBarDelegate<UITabBarDelegate>

@optional
- (void)tabbarDidClicked:(ENHTabBar*) tabbar;

@end

@interface ENHTabBar : UITabBar

@property (nonatomic,weak) id<ENHTabBarDelegate> delegate;

@end
