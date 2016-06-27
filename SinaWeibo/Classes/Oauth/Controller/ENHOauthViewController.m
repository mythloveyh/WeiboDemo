//
//  ENHOauthViewController.m
//  SinaWeibo
//
//  Created by Digger on 15/10/23.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHOauthViewController.h"
#import "UIView+Extension.h"
#import "AFNetworking.h"
#import "ENHAccount.h"
#import "ENHAccountTool.h"
#import "ENHTabberViewController.h"
#import "ENHNewfeatureViewController.h"
#import "ENHNewfeatureTool.h"
#import "MBProgressHUD.h"
@interface ENHOauthViewController()<UIWebViewDelegate>

@end

@implementation ENHOauthViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIWebView* webView = [[UIWebView alloc] init];
    
    //设置webView代理
    webView.delegate = self;
    
    webView.frame = self.view.bounds;
    
    [self.view addSubview:webView];
    
    NSURL* url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2361278060&redirect_uri=http://www.baidu.com"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* requestUrl = request.URL.absoluteString;
    NSRange range = [requestUrl rangeOfString:@"code="];
    if (range.length != 0) {
        NSInteger fromIndex = range.location + range.length;
        NSString* code = [requestUrl substringFromIndex:fromIndex];
        [self accesstokeWithCode:code];
        return NO;
    }
    return YES;
}

-(void)accesstokeWithCode:(NSString*)code{
    
    NSString* post = @"https://api.weibo.com/oauth2/access_token";
    //1、afn管理者
    AFHTTPRequestOperationManager* mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //2、设置请求参数
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    params[@"client_id"] = @"2361278060";
    params[@"client_secret"] = @"d597cb62a909c69cd01721c993c91185";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
    //3、发送请求
    [mgr POST:post parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary*  _Nonnull responseObject) {
        ENHAccount* account = [ENHAccount accountWithDict:responseObject];
        [ENHAccountTool saveAccount:account];
        [ENHNewfeatureTool newfeature];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
