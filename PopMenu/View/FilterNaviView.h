/*********************************************************************************
 *Copyright (c) 2016 Appscomm Inc. All rights reserved.
 *FileName:  FilterNaviView.h
 *Author:  孙红
 *Date:  2016.7.6
 *Description: 类似导航栏的头部视图 两个button和一个显示标题的label
 **********************************************************************************/

#import <UIKit/UIKit.h>

@interface FilterNaviView : UIView

@property (nonatomic, strong) UIButton * rightButton;

/**
 *  设置导航栏标题
 *
 *  @param title 标题
 */
- (void)setNavigationTitle:(NSString *)title;

@end
