//
//  ENHAccount.h
//  SinaWeibo
//
//  Created by Digger on 15/10/26.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ENHAccount : NSObject
@property (nonatomic,strong) NSString* access_token; //access_token	string	用于调用access_token，接口获取授权后的access token。
@property (nonatomic,strong) NSString* expires_in;   //expires_in	string	access_token的生命周期，单位是秒数。
@property (nonatomic,strong) NSString* remind_in;    //remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
@property (nonatomic,strong) NSString* uid;          //uid	string	当前授权用户的UID。

@property (nonatomic,strong) NSDate* create_time;

@property (nonatomic,strong) NSString* name;

+(instancetype)accountWithDict:(NSDictionary*)dict;
@end
