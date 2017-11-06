//
//  QdtDatePickerControllerViewModel.h
//  QdtDatePicker
//
//  Created by qiuzijie on 2017/10/24.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtDateComponentModel.h"
#import "NSDate+Tool.h"

typedef NS_OPTIONS(NSInteger, QdtDatePickerControllerDateType){
    QdtDateTypeYear    = 1,
    QdtDateTypeMonth   = 1 << 1,
    QdtDateTypeDay     = 1 << 2,
    QdtDateTypeHour    = 1 << 3,
    QdtDateTypeMinute  = 1 << 4,
};

@interface QdtDatePickerControllerViewModel : NSObject
@property (nonatomic, strong, readonly) NSMutableArray<QdtDateComponentModel *> *components;
@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *date;


- (instancetype)initWithDate:(NSDate *)date type:(QdtDatePickerControllerDateType)type;
@end
