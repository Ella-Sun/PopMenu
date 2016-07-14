//
//  PopMenu.h
//  PopMenu
//
//  Created by sunhong on 16/7/14.
//  Copyright © 2016年 sunhong. All rights reserved.
//

/**
 *  创建tableview的内容视图，高度比tableview高，其他尺寸相同
 *
 *  需创建一个maskview作为伪视图(并添加点击手势)，点击伪视图，该弹出框消失
 */
#import <UIKit/UIKit.h>

@protocol PopMenuDelegate <NSObject>

- (void)didSelectedItem:(NSInteger)item;

@end

@interface PopMenu : UIView

@property (nonatomic, assign) id<PopMenuDelegate> delegate;

@property (nonatomic, strong) NSArray * itemAry;

@property (nonatomic, assign) BOOL isMaskAvail;

//尖角是在右侧还是左侧
//TODO: 待完成
@property (nonatomic, assign) BOOL pointIsRight;
//尖角X轴位置占总宽的百分比
@property (nonatomic, assign) CGFloat percentPoint;

@property (nonatomic, copy) void(^dismissBlock)();

/**
 *  根据提供的弹出框位置及突出点X轴坐标创建(注：未添加遮罩视图)
 *
 *  @param frame  弹出框位置
 *  @param xPixel 突出点X轴坐标
 *
 *  @return 弹出菜单
 */
- (instancetype)initWithFrame:(CGRect)frame
             andPointXpercent:(CGFloat)xPercent;


/**
 *  根据自身的宽度和弹出按钮的位置得出自身的frame
 *
 *  @param width     自身的宽度
 *  @param frame     弹出按钮的位置
 *  @param maskFrame 伪视图的大小
 *  @param superView 父视图
 *
 *  @return 弹出菜单
 */
- (instancetype)initWithViewWidth:(CGFloat)width
                  targetViewFrame:(CGRect)targetFrame
                    maskViewFrame:(CGRect)maskFrame
                      onSuperView:(UIView *)superView;

/**
 *  添加点击手势
 *
 */
- (void)addTapGestureWithClass:(UIView *)view maskViewFrame:(CGRect)maskFrame;

/**
 *  弹窗消失
 */
- (void)dismiss;

//- (void)refreshUI;

@end
