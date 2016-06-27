//
//  UIBarButtonItem+Extension.h
//  SinaWeibo
//
//  Created by Digger on 15/10/19.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@interface UIBarButtonItem (Extension)

/**
 *  生成UIBarButtonItem
 *
 *  @param action         action
 *  @param image          image
 *  @param highlightImage highlightImage
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem*)itemWithTarget:(id)target action:(SEL)action image:(NSString*)image highlightImage:(NSString*) highlightImage;
@end
