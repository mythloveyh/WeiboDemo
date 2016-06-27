//
//  ENHAccountTool.h
//  SinaWeibo
//
//  Created by Digger on 15/10/26.
//  Copyright © 2015年 Digger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ENHAccount.h"

@interface ENHAccountTool : NSObject

+(void)saveAccount:(ENHAccount*)account;

+(ENHAccount*)account;
@end
