//
//  ViewController.m
//  UMAlertView
//
//  Created by Jyo on 2016. 7. 22..
//  Copyright © 2016년 Jyo. All rights reserved.
//

#import "ViewController.h"
#import "UMAlertView.h"

@interface ViewController ()
<UMAlertViewDelegate>
@property (nonatomic) UMAlertView *umAlertView;
@property (nonatomic) NSArray *array;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.umAlertView = [[UMAlertView alloc] init];
    self.umAlertView.delegate = self;

}
- (void)viewDidAppear:(BOOL)animated {
    
    self.array = [[NSArray alloc] initWithObjects:@"UMData1", @"UMData2", nil];
    [self.umAlertView um_showAlertViewTitle:@"UMAlertView" pickerData:self.array];

}

- (void)selectUMAlertButton {

    NSLog(@"select data : %@", [self.umAlertView selectData]);
    [self.umAlertView um_dismissAlertView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
