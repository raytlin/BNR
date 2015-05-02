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

@end
