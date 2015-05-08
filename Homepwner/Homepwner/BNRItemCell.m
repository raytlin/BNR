//
//  BNRItemCell.m
//  Homepwner
//
//  Created by Ray Lin on 5/8/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)showImage:(id)sender{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
