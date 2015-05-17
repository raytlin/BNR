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

@import CoreData;

@interface BNRItemsStore ()

@property (nonatomic)NSMutableArray* privateItems;
@property (nonatomic, strong)NSMutableArray* allAssetTypes;
@property (nonatomic, strong)NSManagedObjectContext* context;
@property (nonatomic, strong)NSManagedObjectModel* model;

@end

@implementation BNRItemsStore

-(BOOL)saveChanges{
    NSError * error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving %@", [error localizedDescription]);
    }
    return successful;
}

-(NSString*)itemArchivePath{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingString:@"store.data"];
    
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    if (fromIndex == toIndex) {
        return;
    }
    
    BNRItem* item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
    
    double lowerBound = 0.0;
    if (toIndex > 0) {
        [self.privateItems[(toIndex -1)]orderingValue];
    }else{
        lowerBound = [self.privateItems[1] orderingValue] -2.0;
    }
    
    double upperBound;
    if (toIndex < [self.privateItems count]-1) {
        upperBound = [self.privateItems[(toIndex+1)]orderingValue];
    }else{
        upperBound = [self.privateItems[(toIndex -1)]orderingValue]+2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound)/2.0;
    NSLog(@"moving to order %f", newOrderValue);
    item.orderingValue = newOrderValue;
}

-(void)removeItem:(BNRItem *)item{
    [self.privateItems removeObjectIdenticalTo:item];
    
    [self.context deleteObject:item];
    
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
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
        NSString* path = [self itemArchivePath];
        NSURL * storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure" reason:[error localizedDescription] userInfo:nil];
        }
        _context = [[NSManagedObjectContext alloc]init];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllItems];
        
    }
    return self;
}

-(NSArray *)allItems{
    return self.privateItems;
}

-(BNRItem *)createItem{
    double order;
    if ([self.allItems count] == 0) {
        order = 1.0;
    }
    else{
        order = [[self.privateItems lastObject]orderingValue]+1.0;
    }
    
    NSLog(@"adding after %lu items, order = %.2f", (unsigned long)[self.privateItems count], order);
    BNRItem* item = [NSEntityDescription insertNewObjectForEntityForName:@"BNRItem" inManagedObjectContext:self.context];
    item.orderingValue = order;
    
    [self.privateItems addObject:item];
    return item;
}

-(void)loadAllItems{
    if (!self.privateItems) {
        NSFetchRequest * request = [[NSFetchRequest alloc]init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"BNRItem" inManagedObjectContext:self.context];
        request.entity = e;
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sd];
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"reason: %@", [error localizedDescription]];
        }
        self.privateItems = [[NSMutableArray alloc]initWithArray:result];
        
    }
}

-(NSArray *)allAssetTypes{
    if (!_allAssetTypes) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"BNRAssetType" inManagedObjectContext:self.context];
        request.entity = e;
        NSError* error = nil;
        NSArray * result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason %@", [error localizedDescription]];
            
        }
        _allAssetTypes = [result mutableCopy];
    }
    if ([_allAssetTypes count]==0) {
        NSManagedObject* type;
        type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType" inManagedObjectContext:self.context];
        [type setValue:@"Furniture" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType" inManagedObjectContext:self.context];
        [type setValue:@"Jewelty" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType" inManagedObjectContext:self.context];
        [type setValue:@"Electronics" forKey:@"label"];
        [_allAssetTypes addObject:type];
    }
    return _allAssetTypes;
}

@end
