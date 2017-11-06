//
//  NSDate+Tool.m
//  QdtDatePickerControllerDemo
//
//  Created by qiuzijie on 2017/11/6.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "NSDate+Tool.h"

@implementation NSDate (Tool)

- (NSDateComponents *)dateComponents{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond);
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    return dateComponents;
}

- (NSInteger)year{
    return [[self dateComponents] year];
}

- (NSInteger)month{
    return [[self dateComponents] month];
}

- (NSInteger)day{
    return [[self dateComponents] day];
}

- (NSInteger)hour{
    return [[self dateComponents] hour];
}

- (NSInteger)minute{
    return [[self dateComponents] minute];
}

- (NSInteger)second{
    return [[self dateComponents] second];
}

@end
