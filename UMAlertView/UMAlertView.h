//
//  UMAlertView.h
//  UMAlertView
//
//  Created by Jyo on 2016. 7. 22..
//  Copyright © 2016년 Jyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMAlertViewDelegate <NSObject>

- (void)selectUMAlertButton;

@end

@interface UMAlertView : UIView
<UIPickerViewDataSource, UIPickerViewDelegate>

@property UIPickerView *picker;
@property NSArray *pickerTextData;
@property NSString *selectData;

- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data;
- (void)um_dismissAlertView;

// delegate
@property (weak, nonatomic) id<UMAlertViewDelegate> delegate;



@end





