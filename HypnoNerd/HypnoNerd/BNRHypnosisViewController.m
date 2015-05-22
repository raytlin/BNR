//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Ray Lin on 5/3/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRHypnosisViewController.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@property (nonatomic, weak)UITextField* textField;

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
        
        [self.view addSubview:messageLabel];
        
        messageLabel.alpha = 0.0;
        [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:UIViewAnimationCurveEaseIn animations:^{
            messageLabel.alpha = 1.0;
        } completion:nil];
        
        [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
                messageLabel.center = self.view.center;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                int x = arc4random()%width;
                int y = arc4random() % height;
                messageLabel.center = CGPointMake(x, y);
            }];
        } completion:^(BOOL finished){
            NSLog(@"Animation finished");
        }];
        
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:0.0 options:0 animations:^{
        CGRect frame = CGRectMake(40, 70, 240, 30);
        self.textField.frame = frame;
    } completion:NULL];
}

-(void)loadView{
    
    CGRect firstFrame = CGRectMake(160, 240, 100, 150);
    
    
    UIView* backgroundView = [[UIView alloc]initWithFrame:firstFrame];
    backgroundView.backgroundColor = [UIColor redColor];
    
    //CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    //UITextField* textField = [[UITextField alloc]initWithFrame:textFieldRect];
    
    UITextField* textField = [[UITextField alloc]init];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    
    
    self.textField = textField;
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
