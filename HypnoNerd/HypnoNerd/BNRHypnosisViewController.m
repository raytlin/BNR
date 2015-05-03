//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Ray Lin on 5/3/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRHypnosisViewController.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@end

@implementation BNRHypnosisViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.tabBarItem.title = @"hypnotize";
        
    }
    return self;
}

-(void)drawHypnoticMessage:(NSString*)message{
    for (int i =0; i<20; i++){
        UILabel* messageLabel = [[UILabel alloc] init];
        messageLabel.text = message;
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        [messageLabel sizeToFit];
        
        int width = (int)(self.view.bounds.size.width);
        int x = arc4random()%width;
        
        int height = (int)(self.view.bounds.size.height);
        int y = arc4random()%height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x,y);
        messageLabel.frame = frame;
        
        
    }
}

-(void)loadView{
    
    CGRect firstFrame = CGRectMake(160, 240, 100, 150);
    
    
    UIView* backgroundView = [[UIView alloc]initWithFrame:firstFrame];
    backgroundView.backgroundColor = [UIColor redColor];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField* textField = [[UITextField alloc]initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    
    
    
    [backgroundView addSubview:textField];
    
    
    
    self.view = backgroundView;
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    NSLog(@"%@", textField.text);
    return YES;
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
