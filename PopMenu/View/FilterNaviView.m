//
//  FilterNaviView.m
//  Cloud
//
//  Created by sunhong on 16/7/6.
//  Copyright © 2016年 Cloud Funds Management. All rights reserved.
//

#import "FilterNaviView.h"

@interface FilterNaviView ()

@property (nonatomic, strong) UILabel * titleLabel;



@end

static CGFloat btnHeight = 30;
#define xPiex 5

@implementation FilterNaviView

- (void)setNavigationTitle:(NSString *)title {
    UILabel * label = [self viewWithTag:130];
    if (!label) {
        return;
    }
    label.text = title;
}

#pragma mark - init

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:64/255.0 green:128/255.0 blue:244 / 255.0 alpha:1.0];
        [self createDefaultViews];
        [self setNeedsLayout];
    }
    return self;
}

#pragma mark - 创建视图

- (void)createDefaultViews {
    //中间label
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.tag = 130;
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    //左侧按钮
//    _leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    _leftButton.tintColor = [UIColor whiteColor];
//    _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
//    _leftButton.tag = 138;
//    [self addSubview:_leftButton];
    
    //右侧按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.tintColor = [UIColor whiteColor];
    _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [_rightButton setTitle:@"+" forState:UIControlStateNormal];
    _rightButton.tag = 139;
    [self addSubview:_rightButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnWidth = 50;
    
    CGFloat labelWidth = SCREEN_WIDTH - btnWidth*2;
    CGFloat labelHeight = self.bounds.size.height;
    _titleLabel.frame = CGRectMake(btnWidth, 20, labelWidth, labelHeight-20);
    
    CGFloat yPiex = (self.bounds.size.height - btnHeight)*.5 + 10;
    
    CGFloat rightXpiex = self.bounds.size.width - xPiex - btnWidth;
    _rightButton.frame = CGRectMake(rightXpiex, yPiex, btnWidth, btnHeight);
    if (_rightButton.currentBackgroundImage) {
        CGRect leftbtnFrame = _rightButton.frame;
        leftbtnFrame.origin.x = self.bounds.size.width - 10 - btnHeight;;
        leftbtnFrame.size = _rightButton.currentBackgroundImage.size;
        _rightButton.frame = leftbtnFrame;
    }
}


@end
