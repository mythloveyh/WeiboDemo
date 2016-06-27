//
//  ENHTableLoadNew.m
//  SinaWeibo
//
//  Created by Digger on 16/1/13.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import "ENHTableLoadNew.h"

@implementation ENHTableLoadNew

+(instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"ENHTableLoadNew" owner:nil options:nil] lastObject];
}

@end
