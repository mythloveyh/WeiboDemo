//
//  ENHTitleButton.m
//  SinaWeibo
//
//  Created by Digger on 15/12/14.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import "ENHTitleButton.h"
#import "UIView+Extension.h"

@implementation ENHTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置内容居中
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
    return self;
}


//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    CGFloat x = 80;
//    CGFloat y = 0;
//    CGFloat width = 13;
//    CGFloat height = contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGFloat width = 80;
//    CGFloat height = contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //计算titleLable的宽度
//    NSMutableDictionary* attr = [NSMutableDictionary dictionary];
//    attr[NSFontAttributeName] = self.titleLabel.font;
//    CGFloat titleWidth = [self.titleLabel.text sizeWithAttributes:attr].width;
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

@end
