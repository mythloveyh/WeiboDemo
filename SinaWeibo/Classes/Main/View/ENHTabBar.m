//
//  ENHTabBar.m
//  SinaWeibo
//
//  Created by Digger on 15/10/21.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHTabBar.h"
#import "UIView+Extension.h"

@interface ENHTabBar()

@property (nonatomic,weak) UIButton* plusButton;

@end

@implementation ENHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton* plusButton = [[UIButton alloc] init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        plusButton.size = plusButton.currentBackgroundImage.size;
        [self addSubview:plusButton];
        self.plusButton = plusButton;
    }
    return self;
}

- (void)plusButtonClicked{
    if ([self.delegate respondsToSelector:@selector(tabbarDidClicked:)]) {
        [self.delegate tabbarDidClicked:self];
    }
}

- (void)layoutSubviews{

#warning [super layoutSubviews]一定要调用
    [super layoutSubviews];
    
    //计算plusButton位置
    self.plusButton.centerX = self.width * 0.5;
    self.plusButton.centerY = self.height * 0.5;
    
    int buttonIndex = 0;
    int count = self.subviews.count;
    CGFloat buttonWidth = self.width / 5;
    Class class = NSClassFromString(@"UITabBarButton");
    
    for (int i =0; i<count; i++) {
        UIView* child = self.subviews[i];
        if ([child isKindOfClass:class]) {
            child.width = buttonWidth;
            child.x = buttonIndex * buttonWidth;
            buttonIndex++;
        }
        
        if (buttonIndex == 2) {
            buttonIndex++;
        }
    }
}

@end
