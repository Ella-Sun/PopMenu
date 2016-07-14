//
//  PopMenuTableViewCell.m
//  PopMenu
//
//  Created by sunhong on 16/7/14.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "PopMenuTableViewCell.h"

@interface PopMenuTableViewCell ()

@property (nonatomic, weak) UIImageView * iconImage;
@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, strong) UIView * lineView;

@end

@implementation PopMenuTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *iden = @"PopMenuCell";
    PopMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell = [[PopMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.iconImage = iconImage;
        self.iconImage.tag = 351;
        [self addSubview:self.iconImage];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel = titleLabel;
        self.titleLabel.tag = 352;
        [self addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
        lineView.backgroundColor = [UIColor whiteColor];
        lineView.alpha = 0.5;
        self.lineView = lineView;
        self.lineView.tag = 353;
        [self addSubview:lineView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    
    CGFloat iconHeight = 15;
    CGFloat lineHeight = 0.5;
    
    CGFloat xPixel = 8;
    CGFloat titleXpixel = xPixel + iconHeight + 8;
    
    CGFloat iconYpiex = (height - iconHeight) * 0.5;
    
    self.iconImage.frame = CGRectMake(xPixel, iconYpiex, iconHeight, iconHeight);
    self.titleLabel.frame = CGRectMake(titleXpixel, 0, width-iconHeight, height);
    self.lineView.frame = CGRectMake(titleXpixel, height-lineHeight, width-iconHeight, lineHeight);
}

@end
