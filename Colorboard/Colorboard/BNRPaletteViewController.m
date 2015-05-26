//
//  BNRPaletteViewController.m
//  Colorboard
//
//  Created by Ray Lin on 5/23/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRPaletteViewController.h"
#import "BNRColorViewController.h"
#import "BNRColorDescription.h"

@interface BNRPaletteViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic)NSMutableArray* colors;

@end

@implementation BNRPaletteViewController

-(NSMutableArray *)colors{
    if (!_colors) {
        _colors = [NSMutableArray array];
        BNRColorDescription* cd = [[BNRColorDescription alloc]init];
        [_colors addObject:cd];
    }
    return _colors;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.colors count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    BNRColorDescription* cd = self.colors[indexPath.row];
    cell.textLabel.text = cd.name;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"NewColor"]) {
        BNRColorDescription* color = [[BNRColorDescription alloc]init];
        [self.colors addObject:color];
        
        UINavigationController* nc = segue.destinationViewController;
        BNRColorViewController *mvc = (BNRColorViewController*)[nc topViewController];
        
        mvc.colorDescription = color;
    } else if ([segue.identifier isEqualToString:@"ExistingColor"]){
        NSIndexPath* ip = [self.tableView indexPathForCell:sender];
        BNRColorDescription* color = self.colors[ip.row];
        BNRColorViewController *cvc = (BNRColorViewController*)segue.destinationViewController;
        cvc.colorDescription = color;
        cvc.existingColor = YES;
    }
}

@end
