//
//  DayPickerView.m
//  风向标
//
//  Created by 何凯楠 on 15/10/27.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import "XBPicker.h"

#define XBSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define XBSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static CGFloat const DayPickerViewHeight = 246.f;
static CGFloat const DayPickerShowDimissAnimationDuration = 0.5f;

@interface XBPicker()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic , strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *selectedResults;

@property (nonatomic , weak) UIView *converView;

@end

@implementation XBPicker

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        self.frame = CGRectMake(0, XBSCREEN_HEIGHT, XBSCREEN_WIDTH, DayPickerViewHeight);
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setupViews
{
    UIView *aboveBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XBSCREEN_WIDTH, 30)];
    aboveBgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self addSubview:aboveBgView];
    
    CGFloat x = 50;
    CGFloat y = 0;
    CGFloat w = XBSCREEN_WIDTH - 50*2;
    CGFloat h = 30;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(x, y, w, h);
    label.font = [UIFont systemFontOfSize:15.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [aboveBgView addSubview:label];
    self.titleLabel = label;
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(0, 0, 50, 30);
    [dismissBtn setTitle:@"取消" forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [dismissBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    dismissBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [aboveBgView addSubview:dismissBtn];
    self.cancelButton = dismissBtn;
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(XBSCREEN_WIDTH - 50, 0, 50, 30);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [aboveBgView addSubview:sureBtn];
    self.sureButton = sureBtn;

    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, XBSCREEN_WIDTH, 216)];
    self.pickerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.pickerView];
}

- (void)setContents:(NSArray *)contents {
    _contents = contents;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:contents.count];
    for (NSInteger i = 0; i < contents.count; i++) {
        [array addObject:@""];
    }
    self.selectedResults = array;
    [self.pickerView reloadAllComponents];
}


#pragma mark- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.contents.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.contents.count > component) {
        NSArray *components = self.contents[component];
        return components.count;
    }
    return 0;
}

#pragma mark- UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.contents.count > component) {
        NSArray *components = self.contents[component];
        return components[row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.contents.count > component) {
        NSArray *components = self.contents[component];
        NSString *selectedResult = components[row];
        self.selectedResults[component] = selectedResult;
    }
    
}

- (void)setupConverView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *converView = [[UIView alloc] initWithFrame:window.bounds];
    converView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [window addSubview:converView];
    self.converView = converView;
    [self.converView addSubview:self];
    UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeConverView)];
    [self.converView addGestureRecognizer:removeTap];
}

- (void)removeConverView
{
    [self dismiss];
}

- (void)show
{
    [self setupConverView];
    
    [UIView animateWithDuration:DayPickerShowDimissAnimationDuration animations:^{
        self.frame = CGRectMake(0, XBSCREEN_HEIGHT - DayPickerViewHeight, XBSCREEN_WIDTH, DayPickerViewHeight);
        self.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:DayPickerShowDimissAnimationDuration animations:^{
        self.frame = CGRectMake(0, XBSCREEN_HEIGHT, XBSCREEN_WIDTH, DayPickerViewHeight);
        self.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        [self.converView removeFromSuperview];
    }];
}


- (void)dismissBtnClick
{
    [self dismiss];
}

- (void)sureBtnClick
{
    self.resultBlock ? self.resultBlock(self.selectedResults) : nil;
    [self dismiss];
}


@end
