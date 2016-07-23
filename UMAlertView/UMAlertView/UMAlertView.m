//
//  UMAlertView.m
//  UMAlertView
//
//  Created by Jyo on 2016. 7. 22..
//  Copyright © 2016년 Jyo. All rights reserved.
//

#import "UMAlertView.h"

#define UM_ALERT_VIEW_CORNER_RADIUS 3.0f // AlertView Corner Radius
#define UM_ALERT_VIEW_MARGIN_ZERO 0.0f
#define UM_ALERT_VIEW_MARGIN 50.0f
#define UM_ALERT_VIEW_HEIGHT 50.0f
#define UM_ALERT_VIEW_TITLE_TEXT_COLOR [UIColor blackColor] // AlertView Title Color
#define UM_ALERT_VIEW_SELECT_BUTTON_COLOR [UIColor grayColor] // AlertView Button Background Color
#define UM_ALERT_VIEW_SELECT_CANCEL_BUTTON_COLOR [UIColor lightGrayColor]
#define UM_ALERT_VIEW_ALL_BACKGROUND_COLOR [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]
#define UM_ALERT_VIEW_SELECT_BUTTON_TITLE @"Select" // AlertView Button Title
#define UM_ALERT_VIEW_SELECT_CANCEL_BUTTON_TITLE @"Cancel"

static CGFloat duration = 1.0f;
static NSArray *pickerListData = nil;
static BOOL isScrollPickerView = NO;
static NSInteger pickerRow = 0;

@interface UMAlertView()

@property (nonatomic, weak) UIView *umAlertView;
@property (nonatomic, weak) UILabel *alertTitleLabel;
@property (nonatomic, weak) UIPickerView *dataPicker;
@property (nonatomic, weak) UIButton *selectButton;
@end

@implementation UMAlertView

// title, data
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data haveCancelButton:(BOOL)haveCancelButton  {
    
    [self um_showAlertViewTitle:title pickerData:data duration:duration haveCancelButton:haveCancelButton completion:nil];
}

// title, data, completion block
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data haveCancelButton:(BOOL)haveCancelButton completion:(void (^)(void))completed {
    
    [self um_showAlertViewTitle:title pickerData:data duration:duration haveCancelButton:haveCancelButton completion:completed];
}

// title, data, animation time
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data haveCancelButton:(BOOL)haveCancelButton duration:(CGFloat)time {
    
    [self um_showAlertViewTitle:title pickerData:data duration:time haveCancelButton:haveCancelButton completion:nil];
}

// title, data, animation time, completion block
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)time haveCancelButton:(BOOL)haveCancelButton completion:(void (^)(void))completed {
    
    pickerListData = data;
    duration = time;
    isScrollPickerView = NO;
    
    UIView *keyWindow = [self keyWindow];
    
    UIView *umAlertView =[[UIView alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO, UM_ALERT_VIEW_MARGIN_ZERO, keyWindow.frame.size.width - UM_ALERT_VIEW_MARGIN, UM_ALERT_VIEW_MARGIN * 5)];
    [umAlertView setCenter:keyWindow.center];
    umAlertView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    umAlertView.backgroundColor = UM_ALERT_VIEW_ALL_BACKGROUND_COLOR;
    umAlertView.layer.borderWidth = 2.0f;
    umAlertView.layer.cornerRadius = 3 * UM_ALERT_VIEW_CORNER_RADIUS;
    umAlertView.clipsToBounds = YES;
    umAlertView.alpha = 0.0f;
    self.umAlertView = umAlertView;
    
    UILabel *alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO,UM_ALERT_VIEW_MARGIN_ZERO, umAlertView.frame.size.width, UM_ALERT_VIEW_HEIGHT)];
    [alertTitleLabel setText:title];
    [alertTitleLabel setTextColor:UM_ALERT_VIEW_TITLE_TEXT_COLOR];
    [alertTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [umAlertView addSubview:alertTitleLabel];
    self.alertTitleLabel = alertTitleLabel;
    
    UIPickerView *dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO, UM_ALERT_VIEW_HEIGHT, umAlertView.frame.size.width, UM_ALERT_VIEW_HEIGHT * 3)];
    dataPicker.backgroundColor = UM_ALERT_VIEW_ALL_BACKGROUND_COLOR;
    dataPicker.delegate = self;
    dataPicker.dataSource = self;
    [umAlertView addSubview:dataPicker];
    self.dataPicker = dataPicker;
    
    if(haveCancelButton) {
        [self addCancelButton];
    } else {
        CGFloat umAlertViewWidth = self.umAlertView.frame.size.width;
        [self onlySelectButton:umAlertViewWidth];
    }
    
    [keyWindow addSubview:self.umAlertView];
    
    [UIView animateWithDuration:duration animations: ^{
        NSLog(@"animation");
        umAlertView.alpha = 1.0f;
        completed();
    }];
    
    
}

- (void)addCancelButton {
    
    CGFloat umAlertViewWidthDivide = self.umAlertView.frame.size.width / 2;
    [self onlySelectButton:umAlertViewWidthDivide];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(self.selectButton.frame.size.width, self.alertTitleLabel.frame.size.height + self.dataPicker.frame.size.height, self.umAlertView.frame.size.width / 2, UM_ALERT_VIEW_HEIGHT)];
    cancelButton.clipsToBounds = YES;
    [cancelButton setBackgroundColor:UM_ALERT_VIEW_SELECT_CANCEL_BUTTON_COLOR];
    [cancelButton setTitle:UM_ALERT_VIEW_SELECT_CANCEL_BUTTON_TITLE forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(alertCancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.umAlertView addSubview:cancelButton];
}

- (void)onlySelectButton:(CGFloat) width {
    
    UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO, self.alertTitleLabel.frame.size.height + self.dataPicker.frame.size.height, width, UM_ALERT_VIEW_HEIGHT)];
    selectButton.clipsToBounds = YES;
    [selectButton setBackgroundColor:UM_ALERT_VIEW_SELECT_BUTTON_COLOR];
    [selectButton setTitle:UM_ALERT_VIEW_SELECT_BUTTON_TITLE forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(alertButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.selectButton = selectButton;
    
    [self.umAlertView addSubview:selectButton];
}

- (void)um_dismissAlertView {
    
    [UIView animateWithDuration:duration animations:^{
        NSLog(@"anmiation");
        self.umAlertView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.umAlertView removeFromSuperview];
    }];
    
}

- (void)um_dismissAlertViewCompletion:(void(^)(void))complete {
    
    [UIView animateWithDuration:duration animations:^{
        NSLog(@"anmiation");
        self.umAlertView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.umAlertView removeFromSuperview];
        complete();
    }];
    
}

- (UIView *)keyWindow {
    return [UIApplication sharedApplication].delegate.window;
}

// delegate
- (void)alertButtonAction {
    NSLog(@"alertButtonAction");
    
    if(!isScrollPickerView) {
        self.selectData = [pickerListData objectAtIndex:0];
    } else {
        self.selectData = [pickerListData objectAtIndex:pickerRow];
    }
    
    if ([self.delegate respondsToSelector:@selector(selectUMAlertButton)]) {
        [self.delegate selectUMAlertButton];
    }
}

- (void)alertCancelButtonAction {
    NSLog(@"alertCancelButtonAction");
    
    if ([self.delegate respondsToSelector:@selector(selectUMAlertCancelButton)]) {
        [self.delegate selectUMAlertCancelButton];
    }
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [pickerListData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [pickerListData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    isScrollPickerView = YES;
    pickerRow = row;
    
}

@end
