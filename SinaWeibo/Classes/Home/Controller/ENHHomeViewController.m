//
//  ENHHomeViewController.m
//  SinaWeibo
//
//  Created by Digger on 15/10/16.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "MJExtension.h"
#import "ENHHomeViewController.h"
#import "ENHTestViewController.h"
#import "AFNetworking.h"
#import "ENHAccountTool.h"
#import "ENHTitleButton.h"
#import "UIImageView+WebCache.h"
#import "ENHStatus.h"
#import "ENHStatusFrame.h"
#import "ENHUser.h"
#import "UIView+Extension.h"
#import "ENHTableLoadNew.h"
#import "ENHTableViewCell.h"

@interface ENHHomeViewController () <UITableViewDelegate,UITableViewDataSource,ENHDropdownMenuDelegate>
@property (nonatomic,weak) UIButton* titleButton;
@property (nonatomic,strong) NSMutableArray* statusFrames;
@end

@implementation ENHHomeViewController

- (NSArray *)statusFrames{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置用户信息
    [self setUserInfo];
    
    [self setNavigationItmes];
    
    //加载微博数据
    //[self loadNewStatus];
    //设置tableview
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //下拉刷新
    [self refreshData];
    
    self.tableView.tableFooterView = [ENHTableLoadNew footer];
    
    //NSTimer* timer = [NSTimer timerWithTimeInterval:5.f target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  获得未读数
 */
- (void)setupUnreadCount
{
    NSLog(@"%s",__func__);
    //    HWLog(@"setupUnreadCount");
    //    return;
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    ENHAccount *account = [ENHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 微博的未读数
        //        int status = [responseObject[@"status"] intValue];
        // 设置提醒数字
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", status];
        
        // @20 --> @"20"
        // NSNumber --> NSString
        // 设置提醒数字(微博的未读数)
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
}

- (void)refreshData{
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshStatus:refreshControl];
}

- (void)refreshStatus:(UIRefreshControl*) control{
    ENHAccount* account = [ENHAccountTool account];
    AFHTTPRequestOperationManager* mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    ENHStatusFrame* statusFrame = [self.statusFrames firstObject];
    params[@"since_id"] = statusFrame.status.idstr;
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary*  _Nonnull responseObject) {
        NSMutableArray* newData = [NSMutableArray array];
        NSArray* array = responseObject[@"statuses"];
        for (NSDictionary* dict in array) {
            ENHStatusFrame* sFrame = [[ENHStatusFrame alloc] init];
            sFrame.status = [ENHStatus mj_objectWithKeyValues:dict];
            
            [newData addObject:sFrame];
        }
        NSRange range = NSMakeRange(0, [newData count]);
        NSIndexSet* set = [[NSIndexSet alloc] initWithIndexesInRange:range];
        [self.statusFrames insertObjects:newData atIndexes:set];
        
        [control endRefreshing];
        
        if (newData.count) {
            [self.tableView reloadData];
        }
        NSLog(@"%@",responseObject);
        //显示最新微博数量
        [self showNewStatusCount: newData.count];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [control endRefreshing];
    }];
    
}

- (void)showNewStatusCount:(NSInteger) count{
    UILabel* label = [[UILabel alloc] init];
    if (count == 0) {
        label.text = @"没有更新，请稍后再试！";
    }else{
        label.text = [NSString stringWithFormat:@"更新了%ld条微博数据",count];
    }
    
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35.f;
    label.y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.f animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.f delay:1.f options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}


- (void)setUserInfo{
    ENHAccount* account = [ENHAccountTool account];
    AFHTTPRequestOperationManager* mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary*  _Nonnull responseObject) {
        NSString* name = responseObject[@"name"];
        account.name = name;
        [ENHAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

- (void)setNavigationItmes{
    //设置Home的UIbarNavigationItem
    //左侧item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friends) image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    //右侧item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
    // title
    ENHTitleButton* titleBtn = [[ENHTitleButton alloc] init];
    NSString* name = [ENHAccountTool account].name;
    [titleBtn setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    [titleBtn sizeToFit];
    self.navigationItem.titleView = titleBtn;
    [titleBtn addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.titleButton = titleBtn;
}

//- (void)loadNewStatus{
//    ENHAccount* account = [ENHAccountTool account];
//    AFHTTPRequestOperationManager* mgr = [AFHTTPRequestOperationManager manager];
//    NSMutableDictionary* params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = account.access_token;
//    params[@"count"] = @10;
//    [mgr GET:@"https://api.weibo.com/2/statuses/public_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary*  _Nonnull responseObject) {
//        NSMutableArray* newData = [NSMutableArray array];
//        NSArray* array = responseObject[@"statuses"];
//        for (NSDictionary* dict in array) {
//            [newData addObject:[ENHStatus statusInitWithDict:dict]];
//        }
//        [self.statuses addObjectsFromArray:newData];
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        
//    }];
//}

- (void)titleClicked:(UIButton*) titleButton{
    NSLog(@"%s",__func__);
    //创建下拉菜单
    ENHDropdownMenu* menu = [ENHDropdownMenu menu];
    
    menu.content = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    menu.delegate = self;
    //显示
    [menu showFromView:titleButton];
}

- (void)friends{
    NSLog(@"%s",__func__);
}

- (void)pop{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusFrames.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ENHStatusFrame* statusFrame = [self.statusFrames objectAtIndex:indexPath.row];
    return statusFrame.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identify = @"status";
    ENHTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[ENHTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    cell.statusFrame = [self.statusFrames objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ENHTestViewController* test = [[ENHTestViewController alloc] init];
    test.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test animated:YES];
}

#pragma mark -ENHDropdownMenuDelegate代理
-(void)dropdownMenuDidDismiss:(ENHDropdownMenu *)menu{
    [self.titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

-(void)dropdownMenuDidShow:(ENHDropdownMenu *)menu{
    //更改显示箭头
    [self.titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
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
