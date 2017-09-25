//
//  RemoteViewController.m
//  ProjectT100
//
//  Created by qinglong yang on 2017/9/24.
//  Copyright © 2017年 Yangqinglong. All rights reserved.
//

#import "RemoteViewController.h"
#import "VoicePregressView.h"
@interface RemoteViewController ()
@property (nonatomic,strong) VoicePregressView *voiceView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}

-(void)setSubViews{
    self.title = @"远程控制";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _voiceView = [[VoicePregressView alloc]initWithFrame:CGRectMake(50, 50, 20, 300)];
    _voiceView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_voiceView];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerAction
{
    _voiceView.progress += 0.01;
    if (_voiceView.progress > 1.0) {
        [_timer invalidate];
        _timer = nil;
        NSLog(@"完成");
    }
}


@end
