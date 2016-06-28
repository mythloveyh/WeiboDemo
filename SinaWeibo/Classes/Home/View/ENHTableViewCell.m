//
//  ENHTableViewCell.m
//  SinaWeibo
//
//  Created by Digger on 16/1/13.
//  Copyright © 2016年 Digger. All rights reserved.
//

#import "ENHTableViewCell.h"
#import "ENHStatusFrame.h"
#import "ENHUser.h"
#import "ENHStatus.h"
#import "ENHStatusPhoto.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "ENHToolBar.h"

@interface ENHTableViewCell ()

/** 原创微博*/
@property (nonatomic,weak) UIView* originalView;

/** 头像*/
@property (nonatomic,weak) UIImageView* iconView;

/** 会员图标*/
@property (nonatomic,weak) UIImageView* vipView;

/** 配图*/
@property (nonatomic,weak) UIImageView* photoView;

/** 昵称*/
@property (nonatomic,weak) UILabel* nameLabel;

/** 时间*/
@property (nonatomic,weak) UILabel* timeLabel;

/** 来源*/
@property (nonatomic,weak) UILabel* sourceLabel;

/** 内容*/
@property (nonatomic,weak) UILabel* contentLabel;

/** 转发微博整体*/
@property (nonatomic,weak) UIView* retweetView;

/** 转发微博内容 + 昵称 */
@property (nonatomic,weak) UILabel* retweetContentLabel;

/** 转发微博配图*/
@property (nonatomic,weak) UIImageView* retweetPhotoView;

/** 工具栏 */
@property (nonatomic,weak) ENHToolBar* toolBar;
@end

@implementation ENHTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //设置原创微博
        [self setupOriginal];
        //设置转发微博
        [self setupRetweet];
        //设置工具栏
        [self setupToolBar];
    }
    return self;
}

- (void)setupToolBar{
    ENHToolBar* toolBar = [[ENHToolBar alloc] init];
    self.toolBar = toolBar;
    [self.contentView addSubview:toolBar];
}
/**
 *  设置转发微博
 */
-(void)setupRetweet{
    /** 转发微博整体 */
    UIView* retweetView = [[UIView alloc] init];
    self.retweetView = retweetView;
    [self.contentView addSubview:retweetView];
    
    /** 内容*/
    UILabel* retweetContentLabel = [[UILabel alloc] init];
    self.retweetContentLabel = retweetContentLabel;
    [self.retweetView addSubview:retweetContentLabel];
    
    /** 配图*/
    UIImageView* retweetPhotoView = [[UIImageView alloc] init];
    self.retweetPhotoView = retweetPhotoView;
    [self.retweetView addSubview:retweetPhotoView];
}

/**
 *  设置原创微博
 */

-(void)setupOriginal{
    /** 原创微博*/
    UIView* originalView = [[UIView alloc] init];
    self.originalView = originalView;
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    /** 头像*/
    UIImageView* iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self.originalView addSubview:iconView];
    /** 会员图标*/
    UIImageView* vipView = [[UIImageView alloc] init];
    self.vipView = vipView;
    [self.originalView addSubview:vipView];
    /** 配图*/
    UIImageView* photoView = [[UIImageView alloc] init];
    self.photoView = photoView;
    [self.originalView addSubview:photoView];
    /** 昵称*/
    UILabel* nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self.originalView addSubview:nameLabel];
    /** 时间*/
    UILabel* timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self.originalView addSubview:timeLabel];
    /** 来源*/
    UILabel* sourceLabel = [[UILabel alloc] init];
    self.sourceLabel = sourceLabel;
    [self.originalView addSubview:sourceLabel];
    /** 内容*/
    UILabel* contentLabel = [[UILabel alloc] init];
    self.contentLabel = contentLabel;
    [self.originalView addSubview:contentLabel];
}

-(void)setStatusFrame:(ENHStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    self.originalView.frame = statusFrame.originalViewF;
    
    ENHStatus* status = statusFrame.status;
    
    ENHUser* user = status.user;
    /** 头像*/
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /** 会员图标*/
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
        NSString* imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:imageName];
        self.vipView.frame = statusFrame.vipViewF;
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 配图*/
    self.photoView.frame = statusFrame.photoViewF;
    if (status.pic_urls.count > 0) {
        self.photoView.hidden = NO;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:((ENHStatusPhoto*)[status.pic_urls objectAtIndex:0]).thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }else{
        self.photoView.hidden = YES;
    }
    
    /** 昵称*/
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    self.nameLabel.font = EHNStatusNameFont;
    
    /** 时间*/
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = status.created_at;
    self.timeLabel.font = EHNStatusTimeFont;
    /** 来源*/
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
    self.sourceLabel.font = EHNStatusSourceFont;
    
    /** 内容*/
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    self.contentLabel.font = EHNStatusContentFont;
    self.contentLabel.numberOfLines = 0;
    /** 原创微博*/
    
    /** 转发微博 */
    if (status.retweeted_status){
        self.retweetView.frame = statusFrame.retweetViewF;
        self.retweetView.backgroundColor = [UIColor whiteColor];
        self.retweetView.hidden = NO;
        self.retweetContentLabel.hidden = NO;
        ENHStatus* retweetStatus = [ENHStatus statusInitWithDict:status.retweeted_status];
        NSString* contentText = [NSString stringWithFormat:@"@%@:%@",retweetStatus.user.name,retweetStatus.text];
        self.retweetContentLabel.text = contentText;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        self.retweetContentLabel.font = EHNStatusContentFont;
        self.retweetContentLabel.numberOfLines = 0;
        
        if (retweetStatus.havePics) {
            self.retweetPhotoView.hidden = NO;
            /** 配图*/
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:[retweetStatus.pic_urls objectAtIndex:0][@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }else{
             self.retweetPhotoView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
        self.retweetContentLabel.hidden = YES;
        self.retweetPhotoView.hidden = YES;
    }

    self.toolBar.frame = statusFrame.toolBarF;
    self.toolBar.backgroundColor = [UIColor whiteColor];
}

- (void)setFrame:(CGRect)frame{
    frame = CGRectMake(frame.origin.x, frame.origin.y + 10 , frame.size.width, frame.size.height );
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
