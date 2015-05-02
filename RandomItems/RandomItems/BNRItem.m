//
//  BNRItem.m
//  RandomItems
//
//  Created by Ray Lin on 5/1/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

-(void)setItemName:(NSString *)str{
    _itemName = str;
}
-(NSString *)itemName {
    return _itemName;
}
-(void)setSerialNumber:(NSString *)str{
    _serialNumber = str;
}
-(NSString *)serialNumber{
    return _serialNumber;
}
-(void)setValueInDollars:(int)v{
    _valueInDollars = v;
}
-(int)valueInDollars{
    return _valueInDollars;
}
-(NSDate *)dateCreated{
    return _dateCreated;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber{
    self = [super init];
    if (self){
        _itemName = name;
        self.valueInDollars = value;
        self.serialNumber = sNumber;
        _dateCreated = [[NSDate alloc]init];
    }
    return self;
}

-(instancetype)initWithItemName:(NSString *)name{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

-(instancetype)init{
    return [self initWithItemName:@"Item"];
}

@end
