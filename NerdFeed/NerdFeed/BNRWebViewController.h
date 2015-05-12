//
//  BNRWebViewController.h
//  NerdFeed
//
//  Created by Ray Lin on 5/10/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRWebViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic)NSURL* url;

@property(nonatomic, strong)UIToolbar* toolbar;

@end
