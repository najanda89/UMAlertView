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
#define UM_ALERT_VIEW_MARGIN 60.0f
#define UM_ALERT_VIEW_MARGIN_ZERO 0.0f
#define UM_ALERT_VIEW_LABEL_HEIGHT 10.0f
#define UM_ALERT_VIEW_ANIMATION_DURATION 1.0f // AlertView show, dismiss Duration
#define UM_ALERT_VIEW_TITLE_TEXT_COLOR [UIColor blackColor] // AlertView Title Color
#define UM_ALERT_VIEW_SELECT_BUTTON_COLOR [UIColor grayColor] // AlertView Button Background Color
#define UM_ALERT_VIEW_SELECT_BUTTON_TITLE @"Select" // AlertView Button Title


@interface UMAlertView()

@property (nonatomic) UIView *umAlertView;

@end

@implementation UMAlertView

- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data {

    UIView *keyWindow = [self keyWindow];
    if (!keyWindow) {
        return;
    }
    
    UIView *umAlertView =[[UIView alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN / 2, UM_ALERT_VIEW_MARGIN * 2, keyWindow.frame.size.width - UM_ALERT_VIEW_MARGIN, UM_ALERT_VIEW_MARGIN * 5)];
    umAlertView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    umAlertView.backgroundColor = [UIColor whiteColor];
    umAlertView.layer.borderWidth = 2.0f;
    umAlertView.layer.cornerRadius = 3 * UM_ALERT_VIEW_CORNER_RADIUS;
    umAlertView.clipsToBounds = YES;
    umAlertView.alpha = 0.0f;
    
    UILabel *alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO, UM_ALERT_VIEW_MARGIN / 2, umAlertView.frame.size.width, UM_ALERT_VIEW_LABEL_HEIGHT)];
    [alertTitleLabel setText:title];
    [alertTitleLabel setTextColor:UM_ALERT_VIEW_TITLE_TEXT_COLOR];
    [alertTitleLabel setTextAlignment:NSTextAlignmentCenter];
    

    UIPickerView *dataPicker = [[UIPickerView alloc] init];
    [dataPicker setFrame:CGRectMake(UM_ALERT_VIEW_MARGIN_ZERO, 3 * UM_ALERT_VIEW_MARGIN / 3, umAlertView.frame.size.width, umAlertView.frame.size.height - UM_ALERT_VIEW_MARGIN * 2)];
    [dataPicker setBackgroundColor:[UIColor grayColor]];
    
    
    self.picker = dataPicker;
    
    UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(UM_ALERT_VIEW_MARGIN / 2, dataPicker.frame.size.height + alertTitleLabel.frame.size.height + UM_ALERT_VIEW_MARGIN, umAlertView.frame.size.width - UM_ALERT_VIEW_MARGIN, 2 * UM_ALERT_VIEW_MARGIN / 3)];
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
    
    [UIView animateWithDuration:UM_ALERT_VIEW_ANIMATION_DURATION animations: ^{
        NSLog(@"animation");
        umAlertView.alpha = 1.0f;
    }];
    
}

- (void)um_dismissAlertView {
    
    [UIView animateWithDuration:UM_ALERT_VIEW_ANIMATION_DURATION animations:^{
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

@end
