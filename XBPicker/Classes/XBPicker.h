//
//  DayPickerView.h
//  风向标
//
//  Created by 何凯楠 on 15/10/27.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XBPicker : UIView

/**
 数据源
    @[
      @[@"1", @"2", @"3"],
      @[@"1", @"2", @"3"],
      @[@"1", @"2", @"3"]
    ];
 */
@property (nonatomic , strong) NSArray *contents;

@property (nonatomic, copy) void (^resultBlock)(NSArray *results);

/**
 标题
 */
@property (nonatomic, weak) UILabel *titleLabel;

/**
 取消按钮
 */
@property (nonatomic, weak) UIButton *cancelButton;

/**
 确定按钮
 */
@property (nonatomic, weak) UIButton *sureButton;
/**
 显示视图
 */
- (void)show;


@end
