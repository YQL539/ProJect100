//
//  HomeViewController.m
//  ProjectT100
//
//  Created by yangqinglong on 2017/9/19.
//  Copyright © 2017年 Yangqinglong. All rights reserved.
//

#import "HomeViewController.h"
#import "RemoteViewController.h"
#import "TestView.h"
@interface HomeViewController ()
@property (nonatomic,retain) UIButton *button;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)setSubviews{
    self.title = @"主页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 300, 50)];
    [self.view addSubview:_button];
    _button.backgroundColor = [UIColor lightGrayColor];
    [_button setTitle:@"下一页" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(pushtoNext) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}

-(void)pushtoNext{
//    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_button.frame), self.view.frame.size.width - 20, 300)];
//    [self.view addSubview:testView];
    
    RemoteViewController *remoteVC = [[RemoteViewController alloc]init];
    [self.navigationController pushViewController:remoteVC
                                         animated:NO
     ];
}

@end
