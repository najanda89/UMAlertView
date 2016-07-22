# UMAlertView

## Manually

1. Download the latest code version .
2. Open your project in Xcode, drag the UMAlertView folder into your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. You need it with Import UMAlertView.h & UMAlertView.m

## Function

```
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)time;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data completion:(void (^)(void))completed;
- (void)um_showAlertViewTitle:(NSString *)title pickerData:(NSArray *)data duration:(CGFloat)time completion:(void (^)(void))completed;

- (void)um_dismissAlertView;
- (void)um_dismissAlertViewCompletion:(void(^)(void))complete;
```

## Usage

Init, Delegate
```
    umAlertView = [[UMAlertView alloc] init];
    umAlertView.delegate = self;
```

Action
```
    data = [[NSArray alloc] initWithObjects:@"UMData1", @"UMData2", nil];
    [umAlertView um_showAlertViewTitle:@"UMAlertView" pickerData:data];
    [umAlertView um_showAlertViewTitle:@"UMAlertView" pickerData:data duration:3.0f];
```

Dismiss
```
    [self.umAlertView um_dismissAlertView];
```

## Contact

##### If you want to contact me, send email to najanda89@gmail.com
##### Twitter : @najanda89

## License

UMAlertView is released under the MIT license. See LICENSE for details.
