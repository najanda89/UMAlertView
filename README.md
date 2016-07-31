# UMAlertView

## Fixed
Date : 2016. 07. 24
Add cancel button option

## Manually

1. Download the latest code version .
2. Open your project in Xcode, drag the UMAlertView folder into your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. You need it with Import UMAlertView.h & UMAlertView.m

## Function

```objc
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data haveCancelButton:(BOOL)haveCancelButton;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data haveCancelButton:(BOOL)haveCancelButton duration:(CGFloat)time;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data haveCancelButton:(BOOL)haveCancelButton completion:(void (^)(void))completed;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)time haveCancelButton:(BOOL)haveCancelButton completion:(void (^)(void))completed;

- (void)um_dismissAlertView;
- (void)um_dismissAlertViewCompletion:(void(^)(void))complete;
```

## Usage

Init, Delegate
```objc
    umAlertView = [[UMAlertView alloc] init];
    umAlertView.delegate = self;
```

Delegate Method
```objc
- (void)selectUMAlertButton;
- (void)selectUMAlertCancelButton;
```

Action
```objc
    data = [[NSArray alloc] initWithObjects:@"UMData1", @"UMData2", nil];
    [umAlertView um_showAlertViewTitle:@"UMAlertView" pickerData:data haveCancelButton:YES completion:^{
        NSLog(@"UMAlertView show success");
    }];
```

Dismiss
```objc
    [umAlertView um_dismissAlertView];
    [umAlertView um_dismissAlertViewCompletion:^{
        NSLog(@"UMAlertView dismiss success");
    }];
```

## Contact

##### If you want to contact me, send email to najanda89@gmail.com
##### Twitter : @najanda89

## License

UMAlertView is released under the MIT license. See LICENSE for details.
