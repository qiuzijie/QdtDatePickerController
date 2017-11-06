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
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) NSDate *date;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    QdtDatePickerControllerDateType dateType = (QdtDateTypeHour|QdtDateTypeDay|QdtDateTypeMinute|QdtDateTypeYear|QdtDateTypeMonth);
    QdtDatePickerControllerViewModel *vm = [[QdtDatePickerControllerViewModel alloc] initWithDate:self.date type:dateType];
    QdtDatePickerController *datePicker = [[QdtDatePickerController alloc] initWithViewModel:vm selected:^(NSDate *date) {
        self.date = date;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateString = [formatter stringFromDate:date];
            self.label.text = dateString;
        });
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
