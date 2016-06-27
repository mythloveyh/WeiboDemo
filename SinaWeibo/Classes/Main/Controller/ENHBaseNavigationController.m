//
//  ENHBaseNavigationController.m
//  SinaWeibo
//
//  Created by Digger on 15/10/16.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHBaseNavigationController.h"
#import "UIView+Extension.h"

@interface ENHBaseNavigationController ()

@end

@implementation ENHBaseNavigationController

+ (void)initialize{
    //设置整个项目Item主题
    UIBarButtonItem* item = [UIBarButtonItem appearance];
    //设置普通状态
    NSMutableDictionary* normal = [NSMutableDictionary dictionary];
    [normal setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [normal setObject:[UIFont systemFontOfSize:13.f] forKey:NSFontAttributeName];
    [item setTitleTextAttributes:normal forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  统一导航控制器
 *
 *  @param viewController viewController
 *  @param animated       是否动画
 */

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightImage:@"navigationbar_back_highlighted"];
        
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highlightImage:@"navigationbar_more_highlighted"];
        
    }
   
    [super pushViewController:viewController animated:animated];
}

- (void)more{
    [self popToRootViewControllerAnimated:YES];
}

- (void)back{
    [self popViewControllerAnimated:YES];
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
