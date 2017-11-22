//
//  XBViewController.m
//  XBPicker
//
//  Created by bubiqudong on 11/22/2017.
//  Copyright (c) 2017 bubiqudong. All rights reserved.
//

#import "XBViewController.h"
#import <XBPicker/XBPicker.h>

@interface XBViewController ()

@end

@implementation XBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    XBPicker *picker = [XBPicker new];
    picker.contents = @[@[@"1", @"2", @"3"],
                        @[@"1", @"2", @"3"],
                        @[@"1", @"2", @"3"],
                        @[@"1", @"2", @"3"],
                        @[@"1", @"2", @"3"],
                        ];
    [picker show];
    [picker setResultBlock:^(NSArray *results) {
        NSLog(@"%@", results);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
