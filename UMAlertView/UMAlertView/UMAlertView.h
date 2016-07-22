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

@property NSString *selectData;

- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)time;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data completion:(void (^)(void))completed;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)time completion:(void (^)(void))completed;

- (void)um_dismissAlertView;
- (void)um_dismissAlertViewCompletion:(void(^)(void))complete;

// delegate
@property (weak, nonatomic) id<UMAlertViewDelegate> delegate;



@end






