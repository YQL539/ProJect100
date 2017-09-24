//
//  SettingView.m
//  ProjectT100
//
//  Created by yangqinglong on 2017/9/21.
//  Copyright © 2017年 Yangqinglong. All rights reserved.
//

#import "SettingView.h"
@interface SettingView()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong)  UILabel *firstLabel;
@property (nonatomic, strong) UITextField *firstField;
@property (nonatomic,strong)  UILabel *secondLabel;
@property (nonatomic, strong) UITextField *secondField;
@property (nonatomic,strong)  UILabel *thirdLabel;
@property (nonatomic, strong) UITextField *thirdField;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic,copy) NSString *firstStr;
@property (nonatomic,copy) NSString *secondStr;
@property (nonatomic,copy) NSString *thirdStr;
@property (nonatomic,assign) CGFloat keyboardY;
@end
@implementation SettingView

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.layer.cornerRadius = kAlertViewRadius;
        _alertView.layer.masksToBounds = YES;
        _alertView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        
    }
    return _alertView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
        _titleLabel.textColor = kTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [self buttonWithTitle:self.cancelStr titleColor:kCancelTitleColor titleFont:[UIFont systemFontOfSize:kCancelTitleSize] titleBackground:kCancelBackgroundColor btnCornerRadius:kCancelRadius borderColor:kCancelBorderColor borderWith:kCancelBorderWidth buttonSelector:@selector(BtnPressed:)];
        _cancelBtn.tag = 1990;
        
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [self buttonWithTitle:self.sureStr titleColor:kSureTitleColor titleFont:[UIFont systemFontOfSize:kSureTitleSize] titleBackground:kSureBackgroundColor btnCornerRadius:kSureRadius borderColor:kSureBorderColor borderWith:kSurelBorderWidth buttonSelector:@selector(BtnPressed:)];
        _sureBtn.tag = 1991;
        
    }
    return _sureBtn;
}

- (void)gogo:(NSNotification *)sender{
    NSDictionary *dict = sender.userInfo;
    NSString *str = [dict objectForKey:@"UIKeyboardFrameBeginUserInfoKey"];
    if ([str isEqualToString:@"show"]) {
        self.alertView.frame = CGRectMake(kAlertViewEdgeLeft, (SCREENHEIGHT-kAlertViewHeight)/2 - 60, SCREENWIDTH-kAlertViewEdgeLeft*2, kAlertViewHeight);
    }else if ([str isEqualToString:@"hidden"]){
        self.alertView.frame = CGRectMake(kAlertViewEdgeLeft, (SCREENHEIGHT-150)/2, SCREENWIDTH-kAlertViewEdgeLeft*2, kAlertViewHeight);
    }
}

- (id)initWithTitle:(NSString *)titleStr  cancelBtn:(NSString *)cancelBtn sureBtn:(NSString *)sureBtn btnClickBlock:(btnClickBlock)btnClickIndex{
    
    if (self = [super init]) {
        self.firstStr = @"IP:";
        self.secondStr = @"终端端口:";
        self.thirdStr = @"大屏端口:";
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
        self.titleLabel.text = titleStr;
        self.cancelStr = cancelBtn;
        self.sureStr = sureBtn;
        self.btnClickBlock = [btnClickIndex copy];
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        if (self.sureStr != nil) {
            //双按钮
            [self.alertView addSubview:self.cancelBtn];
            
            [self.alertView addSubview:self.sureBtn];
        }else{
            //单按钮
            [self.alertView addSubview:self.cancelBtn];
        }
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    
    self.alertView.frame = CGRectMake(kAlertViewEdgeLeft, (SCREENHEIGHT-kAlertViewHeight)/2-30, SCREENWIDTH-kAlertViewEdgeLeft*2, kAlertViewHeight);
    //添加一条横线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineViewHeight, self.alertView.frame.size.width, 1)];
    lineView.backgroundColor = kLineColor;
    [self.alertView addSubview:lineView];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.alertView.frame.size.width, KTitleheight);
    CGFloat lableWidth = self.alertView.frame.size.width/4;
    CGFloat marginYSpace = 10.0;
    
    _firstLabel = [self LabelWithTitle:_firstStr];
    _firstLabel.frame = CGRectMake(kContentEdgeLeft, CGRectGetMaxY(self.titleLabel.frame)+marginYSpace*2, lableWidth, kContentHeight);
    self.firstField = [self textFieldWithPlaceHolder:@"请输入IP地址"];
    self.firstField.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+4, CGRectGetMaxY(self.titleLabel.frame)+marginYSpace*2, self.alertView.frame.size.width-kContentEdgeLeft*2 - lableWidth - 5, kContentHeight);
    [self.alertView addSubview:self.firstLabel];
    [self.alertView addSubview:self.firstField];
    
    _secondLabel = [self LabelWithTitle:_secondStr];
    _secondLabel.frame = CGRectMake(kContentEdgeLeft, CGRectGetMaxY(self.firstLabel.frame)+marginYSpace, lableWidth, kContentHeight);
    self.secondField = [self textFieldWithPlaceHolder:@"请输入终端端口号"];
    self.secondField.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+4, CGRectGetMaxY(self.firstField.frame)+marginYSpace, self.alertView.frame.size.width-kContentEdgeLeft*2 - lableWidth - 5, kContentHeight);
    [self.alertView addSubview:self.secondLabel];
    [self.alertView addSubview:self.secondField];
    
    _thirdLabel = [self LabelWithTitle:_thirdStr];
    _thirdLabel.frame = CGRectMake(kContentEdgeLeft, CGRectGetMaxY(self.secondLabel.frame)+marginYSpace, lableWidth, kContentHeight);
    self.thirdField = [self textFieldWithPlaceHolder:@"请输入大屏端口号"];
    self.thirdField.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+4, CGRectGetMaxY(self.secondField.frame)+marginYSpace, self.alertView.frame.size.width-kContentEdgeLeft*2 - lableWidth - 5, kContentHeight);
    [self.alertView addSubview:self.thirdLabel];
    [self.alertView addSubview:self.thirdField];
    
    if (self.sureStr != nil) {
        //双按钮
        self.cancelBtn.frame = CGRectMake(kBtnEdgeLeft, CGRectGetMaxY(self.thirdLabel.frame)+marginYSpace*2, self.alertView.frame.size.width/2-kBtnEdgeLeft*2, kBtnHeight);
        
        self.sureBtn.frame = CGRectMake(self.alertView.frame.size.width/2+kBtnEdgeLeft, CGRectGetMaxY(self.thirdLabel.frame)+marginYSpace*2, self.alertView.frame.size.width/2-kBtnEdgeLeft*2, kBtnHeight);
    }else{
        //单按钮
        self.cancelBtn.frame = CGRectMake(kBtnEdgeLeft, CGRectGetMaxY(self.thirdLabel.frame)+marginYSpace*2, self.alertView.frame.size.width-kBtnEdgeLeft*2, kBtnHeight);
    }
    _keyboardY = _sureBtn.frame.origin.y;
}

- (void)show{
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.4 animations:^{
        self.alertView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)cancelBtnPressed{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [self removeFromSuperview];
    }];
}

- (void)BtnPressed:(UIButton *)sender{
    
    [self cancelBtnPressed];
    NSInteger index = sender.tag-1990;
    if (index == 0) {
        
        if (self.btnClickBlock) {
            self.btnClickBlock(0,nil,nil,nil);
        }
    }else if (index == 1){
        
        if (self.btnClickBlock) {
            self.btnClickBlock(1,self.firstField.text,self.secondField.text,self.thirdField.text);
        }
    }
    
    [self endEditing:YES];
}


- (UIButton *)buttonWithTitle:(NSString *)btnTitle titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont titleBackground:(UIColor *)titleBackground btnCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWith:(CGFloat)borderWidth buttonSelector:(SEL)buttonSelector{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = titleFont;
    btn.backgroundColor = titleBackground;
    btn.layer.cornerRadius = radius;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = borderWidth;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:buttonSelector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(UILabel *)LabelWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:kTitleFontSize];
    label.text = title;
    label.textColor = kTitleColor;
    label.layer.borderWidth = kBorderwidth;
    label.layer.borderColor = kborderColor.CGColor;
    label.layer.cornerRadius = kContentRadius;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

-(UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = [UIFont systemFontOfSize:kContentFontSize];
    textField.textColor = kContentColor;
    textField.layer.borderWidth = kBorderwidth;
    textField.layer.borderColor = kborderColor.CGColor;
    textField.layer.cornerRadius = kContentRadius;
    textField.layer.masksToBounds = YES;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.placeholder = placeHolder;
    return  textField;
}


#pragma mark ========================= KeyBoard ==============================

-(void)hideKeyBoard:(NSNotification *)notification{
    NSDictionary *infoDic = notification.userInfo;
    double duration = [infoDic[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame=_alertView.frame;
        frame = CGRectMake(kAlertViewEdgeLeft, (SCREENHEIGHT-kAlertViewHeight)/2-30, SCREENWIDTH-kAlertViewEdgeLeft*2, kAlertViewHeight);
        _alertView.frame = frame;
    }];
}

-(void)showKeyBoard:(NSNotification *)notification{
    NSDictionary *infoDic = notification.userInfo;
    CGRect size = [infoDic[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    CGFloat keyBoardHeight = size.size.height;
    double duration = [infoDic[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGFloat offset = keyBoardHeight - _keyboardY;
    NSLog(@"%f",offset);
    if (_keyboardY < keyBoardHeight)
    {
        [UIView animateWithDuration:duration animations:^{
            _alertView.frame=CGRectMake(kAlertViewEdgeLeft, (SCREENHEIGHT-kAlertViewHeight)/2-30-offset, SCREENWIDTH-kAlertViewEdgeLeft*2, kAlertViewHeight);
        }];
    }
}

@end
