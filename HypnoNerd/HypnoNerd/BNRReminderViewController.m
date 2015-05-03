//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Ray Lin on 5/3/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRReminderViewController.h"
#import "AppDelegate.h"

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        
        
            self.tabBarItem.title = @"Reminder";
        
    }
    return self;
}

- (IBAction)addReminder:(id)sender{
    NSDate* date = self.datePicker.date;
    NSLog(@"setting reminder for %@", date);
    
    //[[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    UILocalNotification *note = [[UILocalNotification alloc]init];
    note.alertBody = @"Hypnotize me";
    note.fireDate = date;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:note];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
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
