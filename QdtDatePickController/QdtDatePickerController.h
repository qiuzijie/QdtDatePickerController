//
//  QdtDatePickerController.h
//  QdtDatePicker
//
//  Created by qiuzijie on 2017/10/24.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtDatePickerControllerViewModel.h"

typedef void(^QdtDatePickerControllerDateSelectedBlock)(NSDate *date);

@interface QdtDatePickerController : UIViewController
@property (nonatomic, strong) QdtDatePickerControllerDateSelectedBlock selectedBlock;
- (instancetype)initWithViewModel:(QdtDatePickerControllerViewModel *)vm selected:(QdtDatePickerControllerDateSelectedBlock)block;
@end

@interface QdtDatePickerControllerAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
@end
