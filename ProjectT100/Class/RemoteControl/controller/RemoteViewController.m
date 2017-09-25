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
    
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAct:)];
    [_voiceView addGestureRecognizer:press];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAct:)];
    [_voiceView addGestureRecognizer:pan];
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
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

//长按函数
-(void)longPressAct:(UILongPressGestureRecognizer*)longpress{
    //手势的状态对象，到达规定时间，3秒钟，触发函数
    if(longpress.state==UIGestureRecognizerStateBegan){
        _voiceView.progress += 0.01;
        NSLog(@"状态开始");
    }
    //当手指离开屏幕时，结束状态
    else if(longpress.state==UIGestureRecognizerStateEnded){
        NSLog(@"结束状态");
        
    }
    
}

//移动事件函数，只要手指坐标在屏幕上发生变化时，函数就会被调用
-(void)panAct:(UIPanGestureRecognizer*)pan{
    
    //获取移动的坐标，现对于视图的坐标系
    //参数：相对的视图对象
    
    //    CGPoint pt = [pan translationInView:self.view];
    //    NSLog(@"pt.x=%.2f,pt.y=%.2f",pt.x,pt.y);
    
    //获取移动时的相对速度
    _voiceView.progress += 0.01;
    CGPoint pv = [pan velocityInView:self.view];
    NSLog(@"pv.x=%.2f,pv.y=%.2f",pv.x,pv.y);
    
    
}

@end
