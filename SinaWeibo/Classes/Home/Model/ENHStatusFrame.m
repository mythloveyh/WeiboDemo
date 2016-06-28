//
//  ENHStatusFrame.m
//  SinaWeibo
//
//  Created by Digger on 16/1/13.
//  Copyright © 2016年 Digger. All rights reserved.
//  一个status 的所有frame模型
//

#import "ENHStatusFrame.h"
#import "ENHStatus.h"
#import "ENHUser.h"

#define ENHStatusBorderW 10

@interface ENHStatusFrame ()


@end

@implementation ENHStatusFrame

- (CGSize)sizeWithText:(NSString*) text font:(UIFont*) font{
    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [text sizeWithAttributes:attrs];
}

- (CGSize)sizeWithText:(NSString*) text font:(UIFont*) font width:(CGFloat) maxWidth{
    NSMutableDictionary* attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize size = CGSizeMake(maxWidth, CGFLOAT_MAX);
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(void)setStatus:(ENHStatus *)status{
    _status = status;
    
    ENHUser* user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat iconWH = 40.f;
    CGFloat iconX = ENHStatusBorderW;
    CGFloat iconY = ENHStatusBorderW;
    self.iconViewF = CGRectMake(iconX, iconY , iconWH, iconWH);
    
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + ENHStatusBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:EHNStatusNameFont];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + ENHStatusBorderW;
        CGFloat vipY = nameY;
        CGFloat vipW  = 20;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + ENHStatusBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:EHNStatusTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + ENHStatusBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:EHNStatusSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + ENHStatusBorderW;
    CGSize contentSize = [self sizeWithText:status.text font:EHNStatusContentFont
                                      width:cellW - 2 * ENHStatusBorderW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    CGFloat photoX = iconX;
    CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + ENHStatusBorderW;
    CGSize photoSize = CGSizeMake(100, 100);
    self.photoViewF = (CGRect){{photoX,photoY},photoSize};

    CGFloat originalX = 0.f;
    CGFloat originalY = 0.f;
    CGFloat originalW = cellW;
    
    
    if (status.isHavePics) {
        CGFloat maxHeight = CGRectGetMaxY(self.photoViewF) + ENHStatusBorderW;
        CGFloat originalH = maxHeight;
        self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
        self.cellHeight = maxHeight;
    }else{
        CGFloat maxHeight = CGRectGetMaxY(self.contentLabelF) + ENHStatusBorderW;
        CGFloat originalH = maxHeight;
        self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
        self.cellHeight = maxHeight;
    }
    
    
    CGFloat toolBarY = 0;
    if (status.retweeted_status) {
        ENHStatus* retweetStatus = [ENHStatus statusInitWithDict:status.retweeted_status];
        CGFloat retweetContentLabelX = iconX;
        CGFloat retweetContentLabelY = ENHStatusBorderW;
        NSString* contentText = [NSString stringWithFormat:@"@%@:%@",retweetStatus.user.name,retweetStatus.text];
        CGSize retweetContentLabelSize = [self sizeWithText:contentText font:EHNStatusContentFont
                                          width:cellW - 2 * ENHStatusBorderW];
        
        self.retweetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        
        if (retweetStatus.havePics) {
            CGFloat retweetPhotoViewX = iconX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(self.retweetContentLabelF) +ENHStatusBorderW;
            CGSize  retweetPhotoViewSize = CGSizeMake(100, 100);
            self.retweetPhotoViewF = (CGRect){{retweetPhotoViewX,retweetPhotoViewY},retweetPhotoViewSize};
            self.retweetViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW,
                                      CGRectGetMaxY(self.retweetPhotoViewF));
            
        }else{
            self.retweetViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW,
                                           CGRectGetMaxY(self.retweetContentLabelF));
        }
        
        toolBarY = CGRectGetMaxY(self.retweetViewF) + 1.f;
    }else{
        toolBarY = CGRectGetMaxY(self.originalViewF) + 1.f;
    }
    
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35.f;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolBarF) + 10.f;
}

@end
