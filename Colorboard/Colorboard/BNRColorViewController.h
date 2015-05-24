//
//  BNRColorViewController.h
//  Colorboard
//
//  Created by Ray Lin on 5/23/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRColorDescription.h"

@interface BNRColorViewController : UIViewController

@property (nonatomic) BOOL existingColor;
@property (nonatomic) BNRColorDescription* colorDescription;

@end
