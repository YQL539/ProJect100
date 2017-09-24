//
//  HomeViewController.m
//  ProjectT100
//
//  Created by yangqinglong on 2017/9/19.
//  Copyright © 2017年 Yangqinglong. All rights reserved.
//

#import "HomeViewController.h"
#import "RemoteViewController.h"
#import "BackgroundView.h"
@interface HomeViewController ()

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
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 300, 50)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushtoNext) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
    
}

-(void)pushtoNext{
    RemoteViewController *remoteVC = [[RemoteViewController alloc]init];
    [self.navigationController pushViewController:remoteVC
                                         animated:NO
     ];
}

@end
