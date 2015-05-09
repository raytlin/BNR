//
//  BNRCoursesViewController.m
//  NerdFeed
//
//  Created by Ray Lin on 5/8/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

#import "BNRCoursesViewController.h"

@interface BNRCoursesViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BNRCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
