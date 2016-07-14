//
//  ViewController.m
//  PopMenu
//
//  Created by sunhong on 16/7/14.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ViewController.h"

#import "FilterNaviView.h"
#import "PopMenu.h"

@interface ViewController ()<PopMenuDelegate>

@property (nonatomic, strong) FilterNaviView * naviView;

@property (nonatomic, strong) PopMenu * popMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect naviFrame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    _naviView = [[FilterNaviView alloc] initWithFrame:naviFrame];
    [self.view addSubview:_naviView];
    
    [_naviView.rightButton addTarget:self action:@selector(setupPopMenu) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupPopMenu {
    if (!_popMenu) {
        
        CGRect maskFrame = self.view.bounds;
        maskFrame.origin.y = CGRectGetMaxY(_naviView.frame);
        maskFrame.size.height = self.view.bounds.size.height - CGRectGetMaxY(_naviView.frame);
        
        /*
        //TODO: 方法一
        CGFloat height = 40 * 3 + 10;//需要加上上方尖角高度
        CGRect popMenuFrame = CGRectMake(SCREEN_WIDTH-100-10, 164, 100, height);
        PopMenu *popMenu = [[PopMenu alloc] initWithFrame:popMenuFrame andPointXpercent:0.8];
        popMenu.delegate = self;
        popMenu.dismissBlock = ^(){
            [_popMenu removeFromSuperview];
            _popMenu = nil;
        };
        [popMenu addTapGestureWithClass:self.view maskViewFrame:maskFrame];
        _popMenu = popMenu;
        [self.view addSubview:popMenu];
        */
        //TODO: 方法二
        CGRect targetFrame = [_naviView convertRect:_naviView.rightButton.frame toView:self.view];
        
        PopMenu *popMenu1 = [[PopMenu alloc] initWithViewWidth:100
                                               targetViewFrame:targetFrame
                                                 maskViewFrame:maskFrame
                                                   onSuperView:self.view];
        popMenu1.delegate = self;
        popMenu1.dismissBlock = ^(){
            [_popMenu removeFromSuperview];
            _popMenu = nil;
        };
        _popMenu = popMenu1;
        [self.view addSubview:popMenu1];
    } else {
        
        [_popMenu removeFromSuperview];
        _popMenu = nil;
    }
    
}

- (void)didSelectedItem:(NSInteger)item {
    NSLog(@"%ld",item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
