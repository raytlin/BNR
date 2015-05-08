//
//  BNRItemsTableView.m
//  Homepwner
//
//  Created by Ray Lin on 5/4/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRItemsTableView.h"
#import "BNRItemCell.h"
#import "BNRImageStore.h"
#import "BNRImageViewController.h"

@interface BNRItemsTableView () <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *imagePopover;

@end

@implementation BNRItemsTableView


-(IBAction)addNewItem:(id)sender{
    
    BNRItem* newItem = [[BNRItemsStore sharedStore]createItem];

    
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
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray* items = [BNRItemsStore sharedStore].allItems;
    
    BNRItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCell" forIndexPath:indexPath];
    
    
    BNRItem* item = items[indexPath.row];
    cell.nameLabel.text = item.itemName;
    cell.valueLabel.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    cell.thumbnailView.image = item.thumbnail;
    cell.serialNumberLabel.text = item.serialNumber;
    
    __weak BNRItemCell * weakCell = cell;
    
    cell.actionBlock = ^{
        NSLog(@"Going to show an image for %@", item);
        BNRItemCell* strongCell = weakCell;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            NSString* itemKey = item.itemKey;
            UIImage *img = [[BNRImageStore sharedStore]imageForKey:itemKey];
            if (!img) {
                return;
            }
            //CGRect rect = [self.view convertRect:cell.thumbnailView.bounds fromView:cell.thumbnailView];
            
            CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds fromView:strongCell.thumbnailView];
            
            BNRImageViewController *ivc = [[BNRImageViewController alloc]init];
            ivc.image = img;
            self.imagePopover = [[UIPopoverController alloc]initWithContentViewController:ivc];
            self.imagePopover.delegate = self;
            self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
            [self.imagePopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    };
    
    return cell;
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    self.imagePopover = nil;
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
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UINib *nib = [UINib nibWithNibName:@"BNRItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BNRItemCell"];
    
}

@end
