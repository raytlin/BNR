//
//  BNRItemsTableView.m
//  Homepwner
//
//  Created by Ray Lin on 5/4/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRItemsTableView.h"

@interface BNRItemsTableView ()

//@property (nonatomic, strong) IBOutlet UIView* headerView;

@end

@implementation BNRItemsTableView

//-(UIView*)headerView{
//    if(!_headerView){
//        [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    return _headerView;
//}

-(IBAction)addNewItem:(id)sender{
    
    BNRItem* newItem = [[BNRItemsStore sharedStore]createItem];
//    NSInteger lastRow = [[BNRItemsStore sharedStore].allItems indexOfObject:newItem];
//    
//    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
//    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc]initForNewItem:YES];
    detailViewController.item = newItem;
    
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:detailViewController];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navController animated:YES completion:nil];
}

-(IBAction)toggleEditingMode:(id)sender{
    if (self.isEditing){
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }
    else{
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

-(instancetype)init{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if(self){
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        
        UIBarButtonItem* bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
//        for (int i =0; i<5; i++) {
//            [[BNRItemsStore sharedStore] createItem];
//        }
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [self init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[BNRItemsStore sharedStore] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray* items = [BNRItemsStore sharedStore].allItems;
    
    BNRItem* item = items[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@): Worth $%d", item.itemName, item.serialNumber, item.valueInDollars];
    
    
//    NSArray* items = [[BNRItemsStore sharedStore] allItems];
//    
//    if (indexPath.row < [items count]){
//        BNRItem* item = items[indexPath.row];
//    
//        cell.textLabel.text = item.description;
//        cell.detailTextLabel.text = item.itemName;
//    }
//    else{
//        cell.textLabel.text = @"no more rows!";
//    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray* items = [[BNRItemsStore sharedStore]allItems];
        BNRItem* item = items[indexPath.row];
        [[BNRItemsStore sharedStore]removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [[BNRItemsStore sharedStore]moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BNRDetailViewController* detailViewController = [[BNRDetailViewController alloc]initForNewItem:NO];
    
    detailViewController.item =[BNRItemsStore sharedStore].allItems[indexPath.row];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
//    UIView* header = self.headerView;
//    [self.tableView setTableHeaderView:header];
}

@end
