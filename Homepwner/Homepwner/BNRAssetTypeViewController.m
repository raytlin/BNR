//
//  BNRAssetTypeViewController.m
//  Homepwner
//
//  Created by Ray Lin on 5/16/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRAssetTypeViewController.h"
#import "BNRItem.h"
#import "BNRItemsStore.h"

@interface BNRAssetTypeViewController ()

@end

@implementation BNRAssetTypeViewController

-(instancetype)init{
    return [super initWithStyle:UITableViewStylePlain];
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [self init];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [[[BNRItemsStore sharedStore]allAssetTypes]count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    NSArray* allAssets = [[BNRItemsStore sharedStore]allAssetTypes];
    NSManagedObject* assetType = allAssets[indexPath.row];
    self.item.assetType = assetType;
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray* allAssets = [[BNRItemsStore sharedStore]allAssetTypes];
    NSManagedObject *assetType = allAssets[indexPath.row];
    
    NSString *assetLabel = [assetType valueForKey:@"label"];
    cell.textLabel.text = assetLabel;
    if (assetType == self.item.assetType) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


@end
