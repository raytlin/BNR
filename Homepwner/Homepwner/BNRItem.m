//
//  BNRItem.m
//  RandomItems
//
//  Created by Ray Lin on 5/1/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _itemName = [aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
    }
    return self;
}

- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber{
    self = [super init];
    if (self){
        _itemName = name;
        self.valueInDollars = value;
        self.serialNumber = sNumber;
        _dateCreated = [[NSDate alloc]init];
        
        NSUUID* uuid = [[NSUUID alloc]init];
        NSString* key = [uuid UUIDString];
        _itemKey = key;
    }
    return self;
}

-(instancetype)initWithItemName:(NSString *)name{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

-(instancetype)init{
    return [self initWithItemName:@"Item"];
}

-(instancetype)initWithitemName:(NSString *)name serialNumber:(NSString *)sNumber{
    BNRItem* item = [self initWithItemName:name valueInDollars:0 serialNumber:sNumber];
    return item;
}
+(instancetype)randomItem{
    NSArray* randomAdjectiveList = @[@"fluffy", @"rusty", @"shiny"];
    NSArray* randomNounList = @[@"bear", @"spork", @"mac"];
    
    //why get a random number this way using % instead of just passing in an argument of the count?
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    //possible errors could occur here bc i chnaged stuff just to see if it would work
    NSString* randomName = [[NSString alloc]initWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    //a single char plus a random number results in a char?????
    NSString* randomSerialNumber = [NSString stringWithFormat:@"%c%c%c", 'O'+arc4random()%10, 'A'+arc4random()%26, 'O'+arc4random()%10];
    
    BNRItem* newItem = [[self alloc]initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}

-(void)dealloc{
    NSLog(@"Destroyed: %@", self);
}

@end
