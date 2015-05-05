//
//  BNRItemsStore.h
//  Homepwner
//
//  Created by Ray Lin on 5/4/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemsStore : NSObject

@property (nonatomic, readonly)NSArray* allItems;


+(instancetype)sharedStore;
-(BNRItem*)createItem;
-(void)removeItem:(BNRItem*)item;

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
