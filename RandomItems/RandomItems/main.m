//
//  main.m
//  RandomItems
//
//  Created by Ray Lin on 5/1/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSMutableArray* items = [[NSMutableArray alloc]init];
//        
//        [items addObject:@"one"];
//        [items addObject:@"two"];
//        [items addObject:@"three"];
//        
//        [items insertObject:@"zero" atIndex:0];
//        
//        
//        
//        for (NSString* item in items){
//            NSLog(@"%@", item);
//        }
//        items = nil;
//        
//        BNRItem* item = [[BNRItem alloc]initWithItemName:@"red sofa" valueInDollars:100 serialNumber:@"A1"];
//        
//        NSLog(@"%@ %@ %@ %d", [item itemName], [item dateCreated], [item serialNumber], [item valueInDollars]);
        
        NSMutableArray* items = [[NSMutableArray alloc] init];
        
        for (int i =0; i < 10; i++ ){
            BNRItem* item = [BNRItem randomItem];
            [items addObject:item];
        }
        
        for (BNRItem* item in items){
            NSLog(@"%@ %@", item.itemName, item.serialNumber);
        }
        
        
    }
    return 0;
}
