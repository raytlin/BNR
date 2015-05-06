//
//  BNRDrawView.h
//  TouchTracker
//
//  Created by Ray Lin on 5/5/15.
//  Copyright (c) 2015 Ray Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRLine.h"

@interface BNRDrawView : UIView

-(void)strokeLine:(BNRLine*)line;

@end
