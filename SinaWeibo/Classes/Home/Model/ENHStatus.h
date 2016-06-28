//
//  ENHStatus.h
//  SinaWeibo
//
//  Created by Digger on 16/1/11.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ENHUser;

@interface ENHStatus : NSObject

@property (nonatomic,copy) NSString* idstr;
@property (nonatomic,copy) NSString* text;
@property (nonatomic,strong) ENHUser* user;
@property (nonatomic,strong) NSString* created_at;
@property (nonatomic,strong) NSString* source;
@property (nonatomic,strong) NSArray* pic_urls;
@property (nonatomic,strong) NSDictionary* retweeted_status;
@property (nonatomic, assign, getter=isHavePics) BOOL havePics;

+ (instancetype)statusInitWithDict:(NSDictionary*) dict;

@end
