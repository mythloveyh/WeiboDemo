//
//  ENHStatusFrame.h
//  SinaWeibo
//
//  Created by Digger on 16/1/13.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define EHNStatusNameFont [UIFont systemFontOfSize:15]
#define EHNStatusTimeFont [UIFont systemFontOfSize:12]
#define EHNStatusSourceFont [UIFont systemFontOfSize:12]
#define EHNStatusContentFont [UIFont systemFontOfSize:12]

@class ENHStatus;

@interface ENHStatusFrame : NSObject

@property (nonatomic,strong) ENHStatus* status;

/** 原创微博*/
@property (nonatomic,assign) CGRect originalViewF;

/** 头像*/
@property (nonatomic,assign) CGRect iconViewF;

/** 会员图标*/
@property (nonatomic,assign) CGRect vipViewF;

/** 配图*/
@property (nonatomic,assign) CGRect photoViewF;

/** 昵称*/
@property (nonatomic,assign) CGRect nameLabelF;

/** 时间*/
@property (nonatomic,assign) CGRect timeLabelF;

/** 来源*/
@property (nonatomic,assign) CGRect sourceLabelF;

/** 内容*/
@property (nonatomic,assign) CGRect contentLabelF;

/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;

/** 转发微博整体*/
@property (nonatomic,assign) CGRect retweetViewF;

/** 转发微博内容 + 昵称 */
@property (nonatomic,assign) CGRect retweetContentLabelF;

/** 转发微博配图*/
@property (nonatomic,assign) CGRect retweetPhotoViewF;

/** 工具栏 */
@property (nonatomic,assign) CGRect toolBarF;

@end
