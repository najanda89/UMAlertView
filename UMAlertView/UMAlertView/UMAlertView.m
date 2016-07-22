//
//  UMAlertView.m
//  UMAlertView
//
//  Created by Jyo on 2016. 7. 22..
//  Copyright © 2016년 Jyo. All rights reserved.
//

#import "UMAlertView.h"
#import "ViewController.h"

#define UM_ALERT_VIEW_CORNER_RADIUS 3.0f // AlertView Corner Radius
#define UM_ALERT_VIEW_MARGIN_ZERO 0.0f
#define UM_ALERT_VIEW_MARGIN 50.0f
#define UM_ALERT_VIEW_HEIGHT 50.0f
#define UM_ALERT_VIEW_TITLE_TEXT_COLOR [UIColor blackColor] // AlertView Title Color
#define UM_ALERT_VIEW_SELECT_BUTTON_COLOR [UIColor grayColor] // AlertView Button Background Color
#define UM_ALERT_VIEW_ALL_BACKGROUND_COLOR [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]
#define UM_ALERT_VIEW_SELECT_BUTTON_TITLE @"Select" // AlertView Button Title

static CGFloat duration = 1.0f;
static NSArray *pickerListData = nil;
static BOOL isScrollPickerView = NO;
static NSInteger pickerRow = 0;

@interface UMAlertView()

@property (nonatomic) UIView *umAlertView;
@property (nonatomic) UIPickerView *picker;

@end

@implementation UMAlertView

// title, data
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data  {
    
    [self um_showAlertViewTitle:title pickerData:data duration:duration completion:nil];
}

// title, data, completion block
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data completion:(void (^)(void))completed {
    
    [self um_showAlertViewTitle:title pickerData:data duration:duration completion:completed];
}

// title, data, animation time
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)time {
    
    [self um_showAlertViewTitle:title pickerData:data duration:time completion:nil];
}

// title, data, animation time, completion block
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)time completion:(void (^)(void))completed {
    
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
    
    UILabel *alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO,UM_ALERT_VIEW_MARGIN_ZERO, umAlertView.frame.size.width, UM_ALERT_VIEW_HEIGHT)];
    [alertTitleLabel setText:title];
    [alertTitleLabel setTextColor:UM_ALERT_VIEW_TITLE_TEXT_COLOR];
    [alertTitleLabel setTextAlignment:NSTextAlignmentCenter];
    

    UIPickerView *dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO, UM_ALERT_VIEW_HEIGHT, umAlertView.frame.size.width, UM_ALERT_VIEW_HEIGHT * 3)];
    dataPicker.backgroundColor = UM_ALERT_VIEW_ALL_BACKGROUND_COLOR;
    dataPicker.delegate = self;
    dataPicker.dataSource = self;
    self.picker = dataPicker;
    
    UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO, alertTitleLabel.frame.size.height + dataPicker.frame.size.height, umAlertView.frame.size.width, UM_ALERT_VIEW_HEIGHT)];
    selectButton.clipsToBounds = YES;
    selectButton.layer.cornerRadius = UM_ALERT_VIEW_CORNER_RADIUS;
    [selectButton setBackgroundColor:UM_ALERT_VIEW_SELECT_BUTTON_COLOR];
    [selectButton setTitle:UM_ALERT_VIEW_SELECT_BUTTON_TITLE forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(alertButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.umAlertView = umAlertView;
    
    [umAlertView addSubview:alertTitleLabel];
    [umAlertView addSubview:selectButton];
    [umAlertView addSubview:dataPicker];
    [keyWindow addSubview:umAlertView];
    
    [UIView animateWithDuration:duration animations: ^{
        NSLog(@"animation");
        umAlertView.alpha = 1.0f;
        completed();
    }];
    
    
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
