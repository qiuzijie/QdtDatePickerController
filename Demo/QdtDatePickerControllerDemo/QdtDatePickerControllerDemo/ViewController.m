//
//  ViewController.m
//  QdtDatePickerControllerDemo
//
//  Created by qiuzijie on 2017/11/6.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "ViewController.h"
#import "QdtDatePickerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    QdtDatePickerControllerDateType dateType = (QdtDateTypeDay|QdtDateTypeYear|QdtDateTypeMonth);
    QdtDatePickerControllerViewModel *vm = [[QdtDatePickerControllerViewModel alloc] initWithDate:nil type:dateType];
    QdtDatePickerController *datePicker = [[QdtDatePickerController alloc] initWithViewModel:vm selected:^(NSDate *date) {
        NSLog(@"%@",date);
    }];
    [self presentViewController:datePicker animated:YES completion:^{
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
