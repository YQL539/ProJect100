//
//  StartViewController.m
//  ProjectT100
//
//  Created by yangqinglong on 2017/9/20.
//  Copyright © 2017年 Yangqinglong. All rights reserved.
//

#import "StartViewController.h"
#import "HomeViewController.h"
#import "SettingView.h"
@interface StartViewController ()
@property (nonatomic,strong) UIButton *settingBtn;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,strong) NSTimer *countTiemr;
@property (nonatomic,assign) CGFloat count;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
}

-(UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.frame = CGRectMake(SCREENWIDTH - 150, SCREENHEIGHT - 80, 120, 60);
        [_settingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
        _settingBtn.backgroundColor = [UIColor whiteColor];
        _settingBtn.titleLabel.font = [UIFont systemFontOfSize:23];
        _settingBtn.layer.borderWidth = 1;
        _settingBtn.layer.cornerRadius = 5;
        _settingBtn.layer.masksToBounds = YES;
        _settingBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _settingBtn.hidden = YES;
        [_settingBtn addTarget:self action:@selector(showSettingIpView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}


-(void)setSubviews{
    _progress = 0.0f;
    _count = 0.0f;
    
    UIImageView *backGroundView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backGroundView.userInteractionEnabled = YES;
    backGroundView.image = [UIImage imageNamed:@"NTX-begenSys"];
    [self.view addSubview:backGroundView];
    
    UIButton *startSysBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startSysBtn.frame = CGRectMake(0, 0, 200, 50);
    startSysBtn.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2+50);
    [startSysBtn setBackgroundImage:[UIImage imageNamed:@"NTX-startBtn"] forState:normal];
    [startSysBtn addTarget:self action:@selector(startSys:) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:startSysBtn];
    
    // 隐藏功能，设置IP地址
    UIImageView *setiConView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 300, SCREENHEIGHT - 300, 300, 300)];
    setiConView.userInteractionEnabled = YES;
    [backGroundView addSubview:setiConView];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(callSettingView:)];
    longPress.minimumPressDuration = 2.0;
    [setiConView addGestureRecognizer:longPress];
    [self.view addSubview:self.settingBtn];
}

#pragma mark - UIGestureRecognizer SEL 设置界面-
- (void)callSettingView:(UIGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.view.userInteractionEnabled = YES;
        _settingBtn.hidden = NO;
    }
}

/**
 唤起设置IP界面
 */
- (void)showSettingIpView{
    SettingView *settingView = [[SettingView alloc] initWithTitle:@"请输入IP" cancelBtn:@"取消" sureBtn:@"确定" btnClickBlock:^(NSInteger index,NSString *ipStr,NSString *firstText,NSString *secondText) {
        if (index == 0) {
            NSLog(@"取消");
        }else if (index == 1){
            NSLog(@"确定");
            // 中控ip
            [[NSUserDefaults standardUserDefaults] setObject:ipStr forKey:kSocketConnectToHost];
            // 中控端口
            [[NSUserDefaults standardUserDefaults] setInteger:[firstText integerValue] forKey:kSocketOnPort];
            //大屏端口
            [[NSUserDefaults standardUserDefaults] setInteger:[secondText integerValue] forKey:kSocketOnScreenPort];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"ip=%@,终端端口=%@,大屏端口=%@",ipStr,firstText,secondText);
        }
    }];
    [settingView show];
}

#pragma mark - UIButton sel 启动系统 -
- (void)startSys:(UIButton *)sender{
 // 调试
    NSString *ipstr = [[NSUserDefaults standardUserDefaults] objectForKey:kSocketConnectToHost];
    NSInteger ifirst = [[NSUserDefaults standardUserDefaults] integerForKey:kSocketOnPort];
    NSInteger ise = [[NSUserDefaults standardUserDefaults] integerForKey:kSocketOnScreenPort];
    NSLog(@"%@,%ld,%ld",ipstr,(long)ifirst,(long)ise);
    if (ipstr && ipstr.length > 0 && ifirst > 0 && ise >0) {
        [self doSomeWorkWithProgress];
    }else{
        [self showAlertWithInfomation:@"请设置IP、终端端口、大屏端口" completedAction:nil];
    }
}

/**
 进度条
 */
- (void)doSomeWorkWithProgress{
    // 开启时序电源
//    kTCSendCmd(@"N131");
    
    MBProgressHUD *mbprog = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mbprog.mode =  MBProgressHUDModeDeterminateHorizontalBar;
    mbprog.labelText = @"初始化中控设备...";
    
    if (_countTiemr == nil) {
        _countTiemr = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(setProgress) userInfo:nil repeats:YES];
        [[NSRunLoop alloc] addTimer:_countTiemr forMode:NSDefaultRunLoopMode];
        [_countTiemr fire];
    }
}
/**
 时间控制
 1、分段发送命令
 0秒：发送“开启时序电源”命令
 15秒：发送“秒后初始化为演示模式”命令
 120秒发送：“初始化终端音量”命令
 2、进度条效果
 */
- (void)setProgress{
    _count += 1.f;
    _progress = _count/2;
//测试测试测试2秒
        if (_count == 150){
//测试测试测试等待设备启动，并发送音量同步的指令
//        kTCSendCmd(@"N261");
        }
    // 进度条
    if (_progress < 1.f) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD HUDForView:self.view].progress = _progress;
        });
    } else if (_progress >= 1.f) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self presentMainView];
        
        [_countTiemr invalidate];
        _countTiemr = nil;
        _progress = 0.f;
        _count = 0.f;
        return;
    }
}

/**
 跳转到主界面
 */
- (void)presentMainView{
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
//    nav.navigationBarHidden = YES;
    [self presentViewController:nav animated:NO completion:nil];
//    [self.navigationController pushViewController:homeVC animated:YES];
}

/**
 点击空白隐藏设置按钮
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _settingBtn.hidden = YES;
}

@end
