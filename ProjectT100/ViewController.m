//
//  ViewController.m
//  ProjectT100
//
//  Created by yangqinglong on 2017/9/19.
//  Copyright © 2017年 Yangqinglong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(330, 0, 700, 44)];
//    backView.backgroundColor = [UIColor redColor];
//    self.navigationItem.titleView = backView;
//    
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    left.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = left;
    
//    ControView *controlView = [[ControView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, 300, 50)];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview:controlView];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
