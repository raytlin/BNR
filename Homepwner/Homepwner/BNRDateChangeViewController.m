//
//  BNRDateChangeViewController.m
//  Homepwner
//
//  Created by Ray Lin on 5/5/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRDateChangeViewController.h"

@interface BNRDateChangeViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *changeDatePicker;

@end

@implementation BNRDateChangeViewController
- (IBAction)saveDate:(id)sender {
    self.item.dateCreated = self.changeDatePicker.date;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"Change Date";
    self.changeDatePicker.date = self.item.dateCreated;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
