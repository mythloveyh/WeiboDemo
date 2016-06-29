//
//  ENHToolBar.m
//  SinaWeibo
//
//  Created by Eigger on 16/6/28.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import "ENHToolBar.h"
#import "ENHStatus.h"

@interface ENHToolBar()

@property (nonatomic,strong) NSMutableArray* btns;
@property (nonatomic,weak) UIButton* retweetBtn;
@property (nonatomic,weak) UIButton* commentBtn;
@property (nonatomic,weak) UIButton* unlikeBtn;

@end

@implementation ENHToolBar

-(NSArray *)btns{
    if(!_btns){
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.retweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment"];
        self.unlikeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike"];
    }
    return self;
}

- (UIButton*)setupBtnWithTitle:(NSString*) title image:(NSString*) image{
    UIButton* btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    CGFloat width = self.frame.size.width / count;
    CGFloat height = self.frame.size.height;
    for (int i = 0; i < count; i ++ ) {
        UIButton* btn = self.subviews[i];
        CGRect frame = CGRectMake(i * width, 0, width, height);
        btn.frame = frame;
    }
}

- (void)setStatus:(ENHStatus *)status{
    _status = status;
    if (status.reposts_count > 0) {
        [self.retweetBtn setTitle:[NSString stringWithFormat:@"%d",status.reposts_count] forState:UIControlStateNormal];
    }  else {
        [self.retweetBtn setTitle:@"转发" forState:UIControlStateNormal];
    }
    
    if (status.comments_count > 0) {
        [self.commentBtn setTitle:[NSString stringWithFormat:@"%d",status.comments_count] forState:UIControlStateNormal];
    }  else {
        [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    }
    
    if (status.attitudes_count > 0) {
        [self.unlikeBtn setTitle:[NSString stringWithFormat:@"%d",status.attitudes_count] forState:UIControlStateNormal];
    }  else {
        [self.unlikeBtn setTitle:@"赞" forState:UIControlStateNormal];
    }
}

@end
