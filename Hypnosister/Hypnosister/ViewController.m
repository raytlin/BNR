//
//  ViewController.m
//  Hypnosister
//
//  Created by Ray Lin on 5/2/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "ViewController.h"
#import "BNRHypnosisView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect firstFrame = CGRectMake(160, 240, 100, 150);
    BNRHypnosisView *firstView = [[BNRHypnosisView alloc]initWithFrame:firstFrame];
    firstView.backgroundColor = [UIColor redColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
