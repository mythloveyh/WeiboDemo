//
//  ENHToolBar.m
//  SinaWeibo
//
//  Created by Eigger on 16/6/28.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import "ENHToolBar.h"

@implementation ENHToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet"];
        [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment"];
        [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike"];
    }
    return self;
}

- (void)setupBtnWithTitle:(NSString*) title image:(NSString*) image{
    UIButton* btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    int count = self.subviews.count;
    CGFloat width = self.frame.size.width / count;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < count; i ++ ) {
        UIButton* btn = self.subviews[i];
        CGRect frame = CGRectMake(i * width, 0, width, height);
        btn.frame = frame;
    }
}

@end
