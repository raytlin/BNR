//
//  BNRItem.h
//  RandomItems
//
//  Created by Ray Lin on 5/1/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRItem : NSObject <NSCoding>

@property (nonatomic, copy)NSString* itemName;
@property (nonatomic, copy)NSString* serialNumber;
@property (nonatomic)int valueInDollars;
@property (nonatomic, strong)NSDate* dateCreated;

@property (nonatomic, copy)NSString* itemKey;

@property (nonatomic, strong) UIImage* thumbnail;

- (void)setThumbnailFromImage:(UIImage*)image;

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

-(instancetype)initWithitemName:(NSString*)name serialNumber:(NSString*)sNumber;

+(instancetype)randomItem;





@end
