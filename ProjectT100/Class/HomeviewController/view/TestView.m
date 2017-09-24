//
//  TestView.m
//  ModelProduct
//
//  Created by qinglong yang on 2017/9/24.
//  Copyright © 2017年 YQL. All rights reserved.
//

#import "TestView.h"

@implementation TestView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor redColor];
    [color set];
    //设置线条颜色
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    //线条拐角
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    //终点处理
    [path moveToPoint:CGPointMake(self.frame.size.width *3.0/4, 0.0)];
    //起点
    [path addLineToPoint:CGPointMake(self.frame.size.width *3.0/4 - 25.0, 30.0)];
    [path addLineToPoint:CGPointMake(0.0, 30)];
    [path addLineToPoint:CGPointMake(0.0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-1,self.frame.size.height-1)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-1,30.0 )];
    [path addLineToPoint:CGPointMake(self.frame.size.width *3.0/4 + 25.0, 30.0)];
    [path closePath];
    //第五条线通过调用closePath方法得到的
     [path stroke];
    //根据坐标点连线
    [path fill];//颜色填充
    
}


@end
