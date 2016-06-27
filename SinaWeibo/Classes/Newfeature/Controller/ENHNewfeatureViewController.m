//
//  ENHNewfeatureViewController.m
//  SinaWeibo
//
//  Created by Digger on 15/10/22.
//  Copyright © 2015年 Digger. All rights reserved.
//

#define ENHNewfeaturePages 4

#import "ENHNewfeatureViewController.h"
#import "UIView+Extension.h"
#import "ENHTabberViewController.h"
#import "UIWindow+Extension.h"
@interface ENHNewfeatureViewController() <UIScrollViewDelegate>

@property (nonatomic,weak) UIPageControl* pageControl;
@end

@implementation ENHNewfeatureViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //1、新建新特性scrollview
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    for (int i =0; i < ENHNewfeaturePages; i ++) {
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.size = scrollView.size;
        imageView.y = 0;
        NSString* imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.x = i * scrollView.width;
        
        if (i == ENHNewfeaturePages - 1) {
            imageView.userInteractionEnabled = YES;
            UIButton* shareButton = [[UIButton alloc] init];
            shareButton.width = 200;
            shareButton.height = 30;
            [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
            [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            shareButton.centerX = imageView.width * 0.5;
            shareButton.centerY = imageView.height * 0.65;
            shareButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
            [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
            [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [shareButton addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:shareButton];
            
            UIButton* startButton = [[UIButton alloc] init];
            [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            startButton.size = startButton.currentBackgroundImage.size;
            startButton.centerX = shareButton.centerX;
            startButton.centerY = imageView.height * 0.72;
            [startButton setTitle:@"开启微博" forState:UIControlStateNormal];
            [startButton addTarget:self action:@selector(startClicked) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:startButton];
        }
        
        [scrollView addSubview:imageView];
    }
    CGSize maxSize = CGSizeMake(scrollView.width * ENHNewfeaturePages, 0);
    scrollView.contentSize = maxSize;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    [self.view addSubview:scrollView];
    
    //添加pagecontrol
    UIPageControl* pageControl = [[UIPageControl alloc] init];
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height * 0.9;
    
    pageControl.numberOfPages = ENHNewfeaturePages;
    UIColor* currentColor = [UIColor colorWithRed:253.f/255.f green:98.f/255.f blue:42.f/255.f alpha:1.0];
    UIColor* backgroundColor = [UIColor colorWithRed:189.f/255.f green:189.f/255.f blue:189.f/255.f alpha:1.0];
    pageControl.pageIndicatorTintColor = backgroundColor;
    pageControl.currentPageIndicatorTintColor = currentColor;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)shareClicked:(UIButton*) shareButton{
    shareButton.selected = !shareButton.selected;
}

- (void)startClicked{
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow switchRootController];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat page = scrollView.contentOffset.x / scrollView.width;
    
    int currentPage = (int)(page + 0.5);
    self.pageControl.currentPage = currentPage;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
