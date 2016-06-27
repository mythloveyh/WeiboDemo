//
//  ENHTabberController.m
//  SinaWeibo
//
//  Created by Digger on 15/10/16.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHTabberViewController.h"
#import "ViewController.h"
#import "ENHHomeViewController.h"
#import "ENHBaseNavigationController.h"
#import "ENHDiscoverViewController.h"
#import "ENHTabBar.h"
@interface ENHTabberViewController () <ENHTabBarDelegate>

@end

@implementation ENHTabberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加自控制器
    //首页
    ENHHomeViewController* home = [[ENHHomeViewController alloc] init];
    [self addChildVcWithController:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    //消息
    ViewController* vc2 = [[ViewController alloc] init];
    [self addChildVcWithController:vc2 title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    ENHDiscoverViewController* vc3 = [[ENHDiscoverViewController alloc] init];
    [self addChildVcWithController:vc3 title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    ViewController* vc4 = [[ViewController alloc] init];
    [self addChildVcWithController:vc4 title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    ENHTabBar* tabbar = [[ENHTabBar alloc] init];
    tabbar.delegate = self;
    
    [self setValue:tabbar forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  添加子控制器
 *
 *  @param viewController 子控制器
 *  @param title          子控制器标题
 *  @param image          TabberItem默认图片
 *  @param selectedImage  TabberItem选中图片
 */
- (void)addChildVcWithController:(UIViewController*) viewController title:(NSString*) title image:(NSString*) image selectedImage:(NSString*) selectedImage{
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    NSMutableDictionary* normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [viewController.tabBarItem setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    NSMutableDictionary* selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [viewController.tabBarItem setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
    ENHBaseNavigationController* nav = [[ENHBaseNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

#pragma mark ENHTabBarDelegate代理

-(void)tabbarDidClicked:(ENHTabBar *)tabbar{
    NSLog(@"%s",__func__);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
