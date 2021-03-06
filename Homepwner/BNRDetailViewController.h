//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Ray Lin on 5/4/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRItem.h"

@interface BNRDetailViewController : UIViewController <UIViewControllerRestoration>

@property (nonatomic, strong) BNRItem* item;

@property (nonatomic, copy)void (^dismissBlock)(void);

-(instancetype)initForNewItem:(BOOL)isNew;

@end
