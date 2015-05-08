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

-(BOOL)saveChanges{
    NSString* path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

-(NSString*)itemArchivePath{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingString:@"items.archive"];
}

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
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc]initPrivate];
    });
    
    return sharedStore;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if (self){
        NSString* path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc]init];
        }
        
    }
    return self;
}

-(NSArray *)allItems{
    return self.privateItems;
}

-(BNRItem *)createItem{
    BNRItem* item = [[BNRItem alloc]init];
    [self.privateItems addObject:item];
    return item;
}

@end
