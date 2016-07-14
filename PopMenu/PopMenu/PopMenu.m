//
//  PopMenu.m
//  PopMenu
//
//  Created by sunhong on 16/7/14.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "PopMenu.h"

#import "PopMenuTableViewCell.h"

@interface PopMenu ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * popMenuTable;

@property (nonatomic, strong) CAShapeLayer * maskLayer;

@property (nonatomic, strong) UIView * maskView;

@end

@implementation PopMenu

#define topSpace 10
#define pointWidth 10

#define leftOrRightSpace 5

#define cellHeight 40.f

/**
 *  移除遮罩视图
 *
 *  @param isMaskAvail 遮罩视图是否可用
 */
- (void)setIsMaskAvail:(BOOL)isMaskAvail {
    _isMaskAvail = isMaskAvail;
    if (!_isMaskAvail && self.maskView) {
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }
}

- (void)setPercentPoint:(CGFloat)percentPoint {
    if (percentPoint > 0.93) {
        percentPoint = 0.93;
    }
    if (percentPoint < 0.05) {
        percentPoint = 0.05;
    }
    _percentPoint = percentPoint;
    
    CAShapeLayer *layer = [self setupMaskLayer];
    self.layer.mask = layer;
}

//TODO: 待完善
- (void)setPointIsRight:(BOOL)pointIsRight {
    _pointIsRight = pointIsRight;
}

/**
 *  刷新界面大小
 */
//- (void)refreshUI {
//    
//    CGFloat height = self.itemAry.count * cellHeight;
//    
//    CGRect selfFrame = self.frame;
//    selfFrame.size.height = height;
//    self.frame = selfFrame;
//    
//    CGRect tableFrame = self.popMenuTable.frame;
//    tableFrame.size.height = height - topSpace;
//    self.popMenuTable.frame = tableFrame;
//}

- (NSArray *)itemAry {
    if (!_itemAry) {
        _itemAry = @[@{@"title":@"收付款",
                       @"icon":@"wave.png"
                       },
                     @{@"title":@"扫一扫",
                       @"icon":@"wave.png"
                       },
                     @{@"title":@"个人主页",
                       @"icon":@"wave.png"
                       }];
    }
    return _itemAry;
}

- (void)createDefaultData {
    
    self.backgroundColor = [UIColor blackColor];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createDefaultData];
        //创建自己的视图
        [self setupPopMenuFrame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
             andPointXpercent:(CGFloat)xPercent {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createDefaultData];
        
        if (xPercent > 0.93) {
            xPercent = 0.93;
        }
        if (xPercent < 0.05) {
            xPercent = 0.05;
        }
        self.percentPoint = xPercent;
        //漏出尖角
        [self setupMaskLayer];
        //创建自己的视图
        [self setupPopMenuFrame];
    }
    return self;
}

- (instancetype)initWithViewWidth:(CGFloat)width
                  targetViewFrame:(CGRect)targetFrame
                    maskViewFrame:(CGRect)maskFrame
                      onSuperView:(UIView *)superView; {
    
    CGRect frame = [self judgeSelfFrameFrompointViewFrame:targetFrame
                                                selfWidth:width];
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createDefaultData];
        
        [self addTapGestureWithClass:superView maskViewFrame:maskFrame];
        //漏出尖角
        [self setupMaskLayer];
        //创建自己的视图
        [self setupPopMenuFrame];
    }
    return self;
}

// 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
//- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
// 将像素point从view中转换到当前视图中，返回在当前视图中的像素值
//- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;

// 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
//- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
// 将rect从view中转换到当前视图中，返回在当前视图中的rect
//- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;

- (CGRect)judgeSelfFrameFrompointViewFrame:(CGRect)pointViewFrame
                                 selfWidth:(CGFloat)width{
    
    CGFloat centerXpixel = CGRectGetMidX(pointViewFrame);
    CGFloat maxYpixel = CGRectGetMaxY(pointViewFrame) + 3;
    
    CGFloat xPixel = centerXpixel - width*0.5;
    CGFloat yPiexl = maxYpixel;
    CGFloat height = self.itemAry.count * cellHeight;
    
    //停靠右侧
    if ((xPixel + width + leftOrRightSpace) > SCREEN_WIDTH) {
        xPixel = SCREEN_WIDTH - width - leftOrRightSpace;
    }
    //停靠左侧
    if (xPixel < 5) {
        xPixel = leftOrRightSpace;
    }
    CGFloat percentPoint = (centerXpixel-xPixel) / width;
    if (percentPoint > 0.93) {
        percentPoint = 0.93;
    }
    if (percentPoint < 0.05) {
        percentPoint = 0.05;
    }
    self.percentPoint = percentPoint;
    
    CGRect frame = CGRectMake(xPixel, yPiexl, width, height);
    
    return frame;
}


/**
 *  通过创建layer出现尖角
 */
- (CAShapeLayer *)setupMaskLayer {
    
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    
    CGPoint point1 = CGPointMake(0, topSpace);//1
    CGPoint point2 = CGPointMake(viewWidth*self.percentPoint-pointWidth*0.5, topSpace);//2
    CGPoint point3 = CGPointMake(viewWidth*self.percentPoint, 0);//3
    CGPoint point4 = CGPointMake(viewWidth*self.percentPoint+pointWidth*0.5, topSpace);//4
    CGPoint point5 = CGPointMake(viewWidth, topSpace);//5
    CGPoint point6 = CGPointMake(viewWidth, viewHeight);//6
    CGPoint point7 = CGPointMake(0, viewHeight);//7
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}

/**
 *  创建tableview
 */
- (void)setupPopMenuFrame {
    
    CGRect tableFrame = self.bounds;
    tableFrame.origin.y = topSpace;
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
//    tableView.separatorColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.bounces = NO;
    [self addSubview:tableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    static NSString *identifier = @"popmenu";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:10.f];
        
        CGRect imageFrmae = cell.imageView.frame;
        imageFrmae.size = CGSizeMake(30, 30);
        cell.imageView.frame = imageFrmae;
    }
     */
    PopMenuTableViewCell *cell = [PopMenuTableViewCell cellWithTableView:tableView];
    
    NSDictionary *item = self.itemAry[indexPath.row];
    NSString* titleText = item[@"title"];
    NSString *iconPath = item[@"icon"];
    
    UIImageView *iconView = [cell viewWithTag:351];
    UILabel * titleLabel = [cell viewWithTag:352];
    
    iconView.image = [UIImage imageNamed:iconPath];
    titleLabel.text = titleText;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(didSelectedItem:)]) {
        [self.delegate didSelectedItem:indexPath.row];
    }
}


#pragma mark - publicMethod

/**
 *  添加点击手势
 *
 */
- (void)addTapGestureWithClass:(UIView *)view maskViewFrame:(CGRect)maskFrame{
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(tapGestureAction)];
    UIView *maskView = [[UIView alloc] initWithFrame:maskFrame];
    maskView.backgroundColor = [UIColor clearColor];
    [maskView addGestureRecognizer:tap];
    self.maskView = maskView;
    [view addSubview:maskView];
}

- (void)tapGestureAction {
    [self dismiss];
}

- (void)dismiss {
    [self removeFromSuperview];
    self.frame = CGRectZero;
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    
    self.dismissBlock();
}


@end
