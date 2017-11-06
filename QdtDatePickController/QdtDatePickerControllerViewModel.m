//
//  QdtDatePickerControllerViewModel.m
//  QdtDatePicker
//
//  Created by qiuzijie on 2017/10/24.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "QdtDatePickerControllerViewModel.h"

@interface QdtDatePickerControllerViewModel ()
@property (nonatomic, strong, readwrite) NSMutableArray<QdtDateComponentModel *> *components;
@property (nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;
@property (nonatomic, assign, readwrite) QdtDatePickerControllerDateType dateType;
@end

@implementation QdtDatePickerControllerViewModel

- (instancetype)initWithDate:(NSDate *)date type:(QdtDatePickerControllerDateType)type
{
    self = [super init];
    if (self) {
        self.date = [NSDate date];
        if (date) {
            self.date = date;
        }
        self.dateType = type;
        [self config];
    }
    return self;
}

- (void)config{
    NSInteger maxYear = self.date.year + 100;
    NSInteger minYear = self.date.year - 100;

    QdtDateComponentModel *year   = [QdtDateComponentModel new];
    QdtDateComponentModel *month  = [QdtDateComponentModel new];
    QdtDateComponentModel *day    = [QdtDateComponentModel new];
    QdtDateComponentModel *hour   = [QdtDateComponentModel new];
    QdtDateComponentModel *minute = [QdtDateComponentModel new];
    
    if ((self.dateType & QdtDateTypeYear) == QdtDateTypeYear) {
        for (NSInteger i = minYear; i <= maxYear; i++) {
            [year.titles addObject:[NSString stringWithFormat:@"%ld年",i]];
        }
        year.selectedIndex = self.date.year - minYear;
    } else {
        [year.titles addObject:[NSString stringWithFormat:@"%ld年",self.date.year]];
        year.selectedIndex = 0;
    }
    
    if ((self.dateType & QdtDateTypeMonth) == QdtDateTypeMonth) {
        for (NSInteger i = 1; i <= 12; i++) {
            [month.titles addObject:[NSString stringWithFormat:@"%02ld月",i]];
        }
        month.selectedIndex = self.date.month-1;
    } else {
        [month.titles addObject:[NSString stringWithFormat:@"%02ld月",self.date.month]];
        month.selectedIndex = 0;
    }
    
    if ((self.dateType & QdtDateTypeDay) == QdtDateTypeDay) {
        for (NSInteger i = 1; i <= 31; i++) {
            [day.titles addObject:[NSString stringWithFormat:@"%02ld日",i]];
        }
        day.selectedIndex = self.date.day-1;
    } else {
        [day.titles addObject:[NSString stringWithFormat:@"%02ld日",self.date.day]];
        day.selectedIndex = 0;
    }
    
    if ((self.dateType & QdtDateTypeHour) == QdtDateTypeHour) {
        for (NSInteger i = 0; i < 24; i++) {
            [hour.titles addObject:[NSString stringWithFormat:@"%02ld时",i]];
        }
        hour.selectedIndex = self.date.hour;
    } else {
        [hour.titles addObject:[NSString stringWithFormat:@"%02ld时",self.date.hour]];
        hour.selectedIndex = 0;
    }
    
    if ((self.dateType & QdtDateTypeMinute) == QdtDateTypeMinute) {
        for (NSInteger i = 0; i < 60; i++) {
            [minute.titles addObject:[NSString stringWithFormat:@"%02ld分",i]];
        }
        minute.selectedIndex = self.date.minute;
    } else {
        [minute.titles addObject:[NSString stringWithFormat:@"%02ld分",self.date.minute]];
        minute.selectedIndex = 0;
    }
    
    [self.components    addObject:year];
    [self.components    addObject:month];
    [self.components    addObject:day];
    [self.components    addObject:hour];
    [self.components    addObject:minute];
}

#pragma mark - LazyLoad

- (NSMutableArray *)components{
    if (!_components) {
        _components = [NSMutableArray new];
    }
    return _components;
}

- (NSFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
        [_dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return _dateFormatter;
}

@end
