//
//  BNRItemsTableView.m
//  Homepwner
//
//  Created by Ray Lin on 5/4/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRItemsTableView.h"

@interface BNRItemsTableView ()

@property (nonatomic, strong) IBOutlet UIView* headerView;

@end

@implementation BNRItemsTableView

-(UIView*)headerView{
    if(!_headerView){
        [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}

-(IBAction)addNewItem:(id)sender{
    
}

-(IBAction)toggleEditingMode:(id)sender{
    
}

-(instancetype)init{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if(self){
        for (int i =0; i<5; i++) {
            [[BNRItemsStore sharedStore] createItem];
        }
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [self init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[BNRItemsStore sharedStore] allItems] count] +1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    
    NSArray* items = [[BNRItemsStore sharedStore] allItems];
    
    if (indexPath.row < [items count]){
        BNRItem* item = items[indexPath.row];
    
        cell.textLabel.text = item.description;
        cell.detailTextLabel.text = item.itemName;
    }
    else{
        cell.textLabel.text = @"no more rows!";
    }
    
    
    return cell;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView* header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

@end
