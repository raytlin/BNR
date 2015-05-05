//
//  BNRItemsStore.m
//  Homepwner
//
//  Created by Ray Lin on 5/4/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRItemsStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemsStore ()

@property (nonatomic)NSMutableArray* privateItems;

@end

@implementation BNRItemsStore

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    if (fromIndex == toIndex) {
        return;
    }
    
    BNRItem* item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
}

-(void)removeItem:(BNRItem *)item{
    [self.privateItems removeObjectIdenticalTo:item];
    
    [[BNRImageStore sharedStore]deleteImageForKey:item.itemKey];
}

+(instancetype)sharedStore{
    static BNRItemsStore* sharedStore = nil;
    
    if (!sharedStore){
        sharedStore = [[self alloc]initPrivate];
    }
    
    return sharedStore;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if (self){
        _privateItems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSArray *)allItems{
    return self.privateItems;
}

-(BNRItem *)createItem{
    BNRItem* item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

@end
