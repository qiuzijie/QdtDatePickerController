//
//  QdtDateComponentModel.m
//  QdtDatePicker
//
//  Created by qiuzijie on 2017/10/25.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "QdtDateComponentModel.h"

@implementation QdtDateComponentModel
- (BOOL)isShow{
    return (_titles.count > 1);
}
- (NSString *)selectedTitle{
    if (_titles.count > _selectedIndex) {
        return _titles[_selectedIndex];
    }
    return nil;
}

- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray new];
    }
    return _titles;
}

@end
