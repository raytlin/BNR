//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Ray Lin on 5/3/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRHypnosisViewController.h"

@interface BNRHypnosisViewController ()

@end

@implementation BNRHypnosisViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.tabBarItem.title = @"hypnotize";
        
    }
    return self;
}

-(void)loadView{
    
    CGRect firstFrame = CGRectMake(160, 240, 100, 150);
    
    
    UIView* backgroundView = [[UIView alloc]initWithFrame:firstFrame];
    backgroundView.backgroundColor = [UIColor redColor];
    
    
    
    //self.view = backgroundView;
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
