//
//  QdtDateComponentModel.h
//  QdtDatePicker
//
//  Created by qiuzijie on 2017/10/25.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtDateComponentModel : NSObject
@property (nonatomic, assign, readonly, getter=isShow) BOOL show;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy, readonly) NSString *selectedTitle;
@end
