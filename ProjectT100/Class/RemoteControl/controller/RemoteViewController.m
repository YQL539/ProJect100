//
//  RemoteViewController.m
//  ProjectT100
//
//  Created by qinglong yang on 2017/9/24.
//  Copyright © 2017年 Yangqinglong. All rights reserved.
//

#import "RemoteViewController.h"

@interface RemoteViewController ()

@end

@implementation RemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}

-(void)setSubViews{
    self.title = @"远程控制";
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
