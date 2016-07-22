# UMAlertView

## Manually

1. Download the latest code version .
2. Open your project in Xcode, drag the UMAlertView folder into your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. You need it with next line
  - #import "UMAlertView.h"
  - #import "UMAlertView.m".

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
```

Dismiss
```
    [self.umAlertView um_dismissAlertView];
```

## Contact

##### If you wish to contact me, email at:najanda89@gmail.com
##### Twitter : @najanda89

## License

UMAlertView is released under the MIT license. See LICENSE for details.
