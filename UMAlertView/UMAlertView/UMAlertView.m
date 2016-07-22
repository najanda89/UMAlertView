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
#define UM_ALERT_VIEW_MARGIN 50.0f
#define UM_ALERT_VIEW_MARGIN_ZERO 0.0f
#define UM_ALERT_VIEW_HEIGHT 50.0f
#define UM_ALERT_VIEW_ANIMATION_DURATION 1.0f // AlertView show, dismiss Duration
#define UM_ALERT_VIEW_TITLE_TEXT_COLOR [UIColor blackColor] // AlertView Title Color
#define UM_ALERT_VIEW_SELECT_BUTTON_COLOR [UIColor grayColor] // AlertView Button Background Color
#define UM_ALERT_VIEW_ALL_BACKGROUND_COLOR [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]
#define UM_ALERT_VIEW_SELECT_BUTTON_TITLE @"Select" // AlertView Button Title


@interface UMAlertView()

@property (nonatomic) UIView *umAlertView;
@property (nonatomic) CGFloat duration;

@end

@implementation UMAlertView

- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data  {
    
    [self um_showAlertViewTitle:title pickerData:data duration:UM_ALERT_VIEW_ANIMATION_DURATION];
}

- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)duration {
    
    self.pickerTextData = data;
    self.duration = duration;
    
    UIView *keyWindow = [self keyWindow];
    
    UIView *umAlertView =[[UIView alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN / 2, UM_ALERT_VIEW_MARGIN * 2, keyWindow.frame.size.width - UM_ALERT_VIEW_MARGIN, UM_ALERT_VIEW_MARGIN * 5)];
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
    
    [UIView animateWithDuration:self.duration animations: ^{
        NSLog(@"animation");
        umAlertView.alpha = 1.0f;
    }];
    
}

- (void)um_dismissAlertView {
    
    [UIView animateWithDuration:self.duration animations:^{
        NSLog(@"anmiation");
        self.umAlertView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.umAlertView removeFromSuperview];
    }];
    
}

- (UIView *)keyWindow {
    return [UIApplication sharedApplication].delegate.window;
}

// delegate
- (void)alertButtonAction {
    NSLog(@"alertButtonAction");
    if ([self.delegate respondsToSelector:@selector(selectUMAlertButton)]) {
        [self.delegate selectUMAlertButton];
    }
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.pickerTextData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.pickerTextData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectData = [self.pickerTextData objectAtIndex:row];
    
}

@end
