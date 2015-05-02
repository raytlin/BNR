//
//  BNRItem.h
//  RandomItems
//
//  Created by Ray Lin on 5/1/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString* _itemName;
    NSString* _serialNumber;
    int _valueInDollars;
    NSDate* _dateCreated;
}

- (void) setItemName:(NSString*)str;
- (NSString*) itemName;

- (void)setSerialNumber:(NSString*)str;
- (NSString*)serialNumber;

-(void)setValueInDollars:(int)v;
- (int)valueInDollars;

-(NSDate *)dateCreated;

//designamted initializer
-(instancetype)initWithItemName:(NSString*)name valueInDollars:(int)value serialNumber:(NSString*)sNumber;

-(instancetype)initWithItemName:(NSString*)name;

+(instancetype)randomItem;





@end
