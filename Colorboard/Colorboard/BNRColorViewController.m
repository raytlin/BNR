//
//  BNRColorViewController.m
//  Colorboard
//
//  Created by Ray Lin on 5/23/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRColorViewController.h"

@interface BNRColorViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end

@implementation BNRColorViewController

- (IBAction)changeColor:(id)sender {
    float red = self.redSlider.value;
    float blue = self.blueSlider.value;
    float green = self.greenSlider.value;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.view.backgroundColor = color;
    
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
