//
//  ENHUser.h
//  SinaWeibo
//
//  Created by Digger on 16/1/11.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ENHUser : NSObject

@property (nonatomic,copy) NSString* idstr;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* profile_image_url;

@property (nonatomic,assign) int mbtype;
@property (nonatomic,assign) int mbrank;

@property (nonatomic,assign,getter= isVip) BOOL vip;

+ (instancetype)userInitWithDict:(NSDictionary*) dict;

@end
