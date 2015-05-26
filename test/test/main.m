//
//  main.m
//  test
//
//  Created by Ray Lin on 5/25/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NSString* stringOne = @"first string";
        NSString* stringTwo = @"second string";
        
        NSMutableString* stringThree = [[NSMutableString alloc]initWithString:@"third string"];
        stringTwo = stringThree;
        
        
        [stringThree appendString:@"ass"];
        
        stringOne = stringThree;
        
        NSLog(@"%@, %@, %@", stringOne, stringTwo, stringThree);
    }
    return 0;
}
