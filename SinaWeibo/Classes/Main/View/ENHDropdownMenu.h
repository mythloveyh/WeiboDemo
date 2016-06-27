//
//  ENHDropdownMenu.h
//  SinaWeibo
//
//  Created by Digger on 15/10/20.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@class ENHDropdownMenu;

@protocol ENHDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(ENHDropdownMenu*) menu;
- (void)dropdownMenuDidShow:(ENHDropdownMenu*) menu;
@end

@interface ENHDropdownMenu : UIView

+(instancetype)menu;

- (void)showFromView:(UIView*) from;

- (void)dismiss;

@property (nonatomic,weak) id<ENHDropdownMenuDelegate> delegate;
@property (nonatomic,strong) UIView* content;
@property (nonatomic,strong) UIViewController* contentController;

@end
