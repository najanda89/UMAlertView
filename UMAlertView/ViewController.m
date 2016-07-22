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
<UMAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic) UMAlertView *umAlertView;
@property (nonatomic) NSArray *array;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.umAlertView = [[UMAlertView alloc] init];
    self.umAlertView.delegate = self;
    
    [self.umAlertView picker].delegate = self;
    [self.umAlertView picker].dataSource = self;
    
    NSLog(@"view did load");
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated {
    
    self.array = [[NSArray alloc] initWithObjects:@"test1", @"test2", nil];
    [self.umAlertView um_showAlertViewTitle:@"직업 선택" pickerData:self.array];

}

- (void)selectUMAlertButton {
    
    NSLog(@"UMAlertButton Select");
    [self.umAlertView um_dismissAlertView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.array count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.array objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"select data : %@", [self.array objectAtIndex:row]);
    
}



@end
