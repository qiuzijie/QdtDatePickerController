//
//  QdtDatePickerController.m
//  QdtDatePicker
//
//  Created by qiuzijie on 2017/10/24.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "QdtDatePickerController.h"

static const CGFloat kDatePickerWindowHeight = 280;

@interface QdtDatePickerController ()<UIViewControllerTransitioningDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIVisualEffectView *backgroundEffectView;
@property (weak, nonatomic) IBOutlet UIButton           *backgroundButton;
@property (weak, nonatomic) IBOutlet UIView             *datePickerWindow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickerWindowBottomConstranit;
@property (weak, nonatomic) IBOutlet UIButton           *confirmButton;
@property (weak, nonatomic) IBOutlet UIPickerView       *pickerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmButtonHeight;

@property (nonatomic, strong) QdtDatePickerControllerViewModel *viewModel;

@end

@implementation QdtDatePickerController

- (instancetype)initWithViewModel:(QdtDatePickerControllerViewModel *)vm selected:(QdtDatePickerControllerDateSelectedBlock)block{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (self) {
        if (!vm) {
            vm = [[QdtDatePickerControllerViewModel alloc] initWithDate:nil type:(QdtDateTypeYear|QdtDateTypeMonth|QdtDateTypeDay|QdtDateTypeHour|QdtDateTypeMinute)];
        }
        self.viewModel = vm;
        self.selectedBlock = block;
        self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIScreen mainScreen].bounds.size.width > 800) {
        self.confirmButtonHeight.constant = 44 + 20;
    } else {
        self.confirmButtonHeight.constant = 44;
    }
    self.transitioningDelegate = self;
    self.backgroundEffectView.alpha = 0;
    [self selectPickerViewSpecifiedDate];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    [self performSelector:@selector(show) withObject:self afterDelay:CGFLOAT_MIN];
}

- (void)selectPickerViewSpecifiedDate{
    for (NSInteger i = 0; i < self.viewModel.components.count; i++) {
        QdtDateComponentModel *component = self.viewModel.components[i];
        [self.pickerView selectRow:component.selectedIndex inComponent:i animated:NO];
    }
}

- (void)show{
    self.datePickerWindowBottomConstranit.constant = 0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundEffectView.alpha = 0.8;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        ;
    }];
}

- (void)dismiss{
    self.datePickerWindowBottomConstranit.constant = -kDatePickerWindowHeight;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundEffectView.alpha = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            ;
        }];
    }];
}

- (IBAction)didTapBackgroundButton:(UIButton *)sender {
    [self dismiss];
}

- (IBAction)didTapConfirmButton:(UIButton *)sender {
    if (self.selectedBlock) {
        self.selectedBlock(self.viewModel.date);
    }
    [self dismiss];
}

- (NSString *)titleOfComponentAtIndex:(NSInteger)index{
    QdtDateComponentModel *component = self.viewModel.components[index];
    NSInteger selected = [self.pickerView selectedRowInComponent:index];
    if (component.titles.count > selected) {
        NSString *title = component.titles[selected];
        return  [title substringToIndex:(title.length - 1)];
    }
    return @"0";
}

#pragma mark - UIPickerView Datasource
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return self.viewModel.components.count;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.viewModel.components[component].titles.count;
}
#pragma mark - UIPickerView Delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (!self.viewModel.components[component].isShow) {
        return 0;
    }
    NSInteger count = 0;
    for (QdtDateComponentModel *component in self.viewModel.components) {
        if (component.isShow) {
            count++;
        }
    }
    return ((CGRectGetWidth(self.pickerView.bounds)-16) / count);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = (UILabel *)view;
    if (label) {
        
    } else {
        label               = [UILabel new];
        label.font          = [UIFont systemFontOfSize:16];
        label.textColor     = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = 0.8;
    }
    label.text = self.viewModel.components[component].titles[row];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSDate *date = self.viewModel.date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];

    switch (component) {
        case 0:
            components = [self resetDaysOfDate:date components:components];
            [components setYear:[[self titleOfComponentAtIndex:0] integerValue]];
            break;
        case 1:
            components = [self resetDaysOfDate:date components:components];
            [components setMonth:[[self titleOfComponentAtIndex:1] integerValue]];
            break;
        case 2:
            components = [self resetDaysOfDate:date components:components];
            break;
        case 3:
            [components setHour:[[self titleOfComponentAtIndex:3] integerValue]];
            break;
        case 4:
            [components setMinute:[[self titleOfComponentAtIndex:4] integerValue]];
            break;
        default:
            break;
    }
    date = [calendar dateFromComponents:components];
    self.viewModel.date = date;
}

- (NSInteger)maxDaysOfMonthByDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *monthComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
    [monthComponents setYear:[[self titleOfComponentAtIndex:0] integerValue]];
    [monthComponents setMonth:[[self titleOfComponentAtIndex:1] integerValue]];
    NSDate *monthDate = [calendar dateFromComponents:monthComponents];
    NSInteger max = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:monthDate].length;
    return max;
}

- (NSDateComponents *)resetDaysOfDate:(NSDate *)date components:(NSDateComponents *)components{
    NSInteger max = [self maxDaysOfMonthByDate:date];
    NSInteger day = [[self titleOfComponentAtIndex:2] integerValue];
    if (day > max) {
        [self.pickerView selectRow:(max - 1) inComponent:2 animated:YES];
        [components setDay:max];
    } else{
        [components setDay:day];
    }
    return components;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    QdtDatePickerControllerAnimationController *controller = [[QdtDatePickerControllerAnimationController alloc] init];
    return controller;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    
}

@end

@implementation QdtDatePickerControllerAnimationController

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    [[transitionContext containerView] addSubview:toVC.view];
    [transitionContext completeTransition:YES];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0;
}

@end




