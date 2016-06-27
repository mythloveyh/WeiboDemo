//
//  ENHDiscoverViewController.m
//  SinaWeibo
//
//  Created by Digger on 15/10/20.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHDiscoverViewController.h"
#import "ENHSearchBar.h"
@implementation ENHDiscoverViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
//    UISearchBar* searchBar = [[UISearchBar alloc] init];
//    
//    self.navigationItem.titleView = searchBar;
//    
//    UITextField* searchBar = [[UITextField alloc] init];
//    searchBar.height = 30.f;
//    searchBar.width = 300.f;
//    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
//    
//    //放大镜
//    UIImageView* searchIcon = [[UIImageView alloc] init];
//    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
//    searchIcon.height = 30.f;
//    searchIcon.width = 30.f;
//    searchIcon.contentMode = UIViewContentModeCenter;
//    searchBar.font = [UIFont systemFontOfSize:15.f];
//    searchBar.placeholder = @"请输入搜索内容";
//    searchBar.leftView = searchIcon;
//    searchBar.leftViewMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = [ENHSearchBar searchBar];
}



@end
