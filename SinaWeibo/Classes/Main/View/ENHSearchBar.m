//
//  ENHSearchBar.m
//  SinaWeibo
//
//  Created by Digger on 15/10/20.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHSearchBar.h"

@implementation ENHSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.height = 30.f;
        self.width = 300.f;
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        //放大镜
        UIImageView* searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.height = 30.f;
        searchIcon.width = 30.f;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.font = [UIFont systemFontOfSize:15.f];
        self.placeholder = @"请输入搜索内容";
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;

    }
    return self;
}

+(instancetype)searchBar{
    return [[self alloc] init];
}

@end
