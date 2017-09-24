//
//  ControView.m
//  ProjectT100
//
//  Created by yangqinglong on 2017/9/19.
//  Copyright © 2017年 Yangqinglong. All rights reserved.
//

#import "ControllerView.h"

@implementation ControllerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSubviewsWithFrame:frame];
    }
    return self;
}

-(void)setSubviewsWithFrame:(CGRect)frame
{
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self addSubview:mainView];
    
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(0, 0, frame.size.width/3, frame.size.height);
    [firstBtn setTitle:@"Windows" forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [firstBtn addTarget:self action:@selector(firstBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.layer.borderColor = [UIColor blackColor].CGColor;
    firstBtn.layer.borderWidth = 1.0;
    [mainView addSubview:firstBtn];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(CGRectGetMaxX(firstBtn.frame), 0, frame.size.width/3, frame.size.height);
    [secondBtn setImage:[UIImage imageNamed:@"microPhone"] forState:UIControlStateNormal];
    secondBtn.layer.borderColor = [UIColor blackColor].CGColor;
    secondBtn.layer.borderWidth = 1.0;
    [secondBtn addTarget:self action:@selector(secondBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:secondBtn];
    
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn.frame = CGRectMake(CGRectGetMaxX(secondBtn.frame), 0, frame.size.width/3, frame.size.height);
    thirdBtn.layer.borderColor = [UIColor blackColor].CGColor;
    thirdBtn.layer.borderWidth = 1.0;
    [thirdBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [thirdBtn addTarget:self action:@selector(thirdBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:thirdBtn];
    
}

-(void)firstBtnDidClicked:(UIButton *)button{
    NSLog(@"firstBtnDidClicked");
}

-(void)secondBtnDidClicked:(UIButton *)button{
    NSLog(@"secondBtnDidClicked");
}

-(void)thirdBtnDidClicked:(UIButton *)button{
    NSLog(@"thirdBtnDidClicked");
}
@end
