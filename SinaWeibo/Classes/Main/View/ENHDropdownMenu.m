//
//  ENHDropdownMenu.m
//  SinaWeibo
//
//  Created by Digger on 15/10/20.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHDropdownMenu.h"

@interface ENHDropdownMenu()
@property (weak,nonatomic) UIImageView* containerView;
@end

@implementation ENHDropdownMenu

-(UIImageView *)containerView{
    if (!_containerView) {
        UIImageView* contentView = [[UIImageView alloc] init];
        
        UIImage* backgroundImage =[UIImage imageNamed:@"popover_background"];
        contentView.image = backgroundImage;
        //不规则图片不能水平拉伸
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        self.containerView = contentView;
    }
    return _containerView;
}

-(void)setContent:(UIView *)content{
    _content = content;
    content.x = 10;
    content.y = 15;
    //设置containerView高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 10.f;
    //设置containerView宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10.f;
    
    //设置content宽度
    //content.width = self.containerView.width - 2 * content.x;
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    self.content = contentController.view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        }
    return self;
}

+(instancetype)menu{
    return [[self alloc] init];
}

- (void)dismiss{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)showFromView:(UIView *)from{
    UIWindow* window = [[UIApplication sharedApplication].windows lastObject];
    //设置尺寸
    self.frame = window.bounds;
    //UIWindow* window = self.view.window;  可能为空
    
    //设置位置
    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    self.containerView.y = CGRectGetMaxY(newFrame);
    self.containerView.centerX = CGRectGetMidX(newFrame);
    [window addSubview:self];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

@end
