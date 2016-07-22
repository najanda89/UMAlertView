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
@property (nonatomic, weak) IBOutlet UILabel *dataLabel;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.umAlertView = [[UMAlertView alloc] init];
    self.umAlertView.delegate = self;
    
}

- (IBAction)showUMAlertView:(id)sender {
    [self.dataLabel setHidden:YES];
    NSArray *array = [[NSArray alloc] initWithObjects:@"UMData1", @"UMData2", @"UMData3", @"UMData4", @"UMData5", nil];
    [self.umAlertView um_showAlertViewTitle:@"UMAlertView" pickerData:array];
    
}

- (void)selectUMAlertButton {
    [self.dataLabel setHidden:NO];
    NSLog(@"ViewController Show Data : %@", [self.umAlertView selectData]);
    [self.dataLabel setText:[self.umAlertView selectData]];
    [self.umAlertView um_dismissAlertView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
