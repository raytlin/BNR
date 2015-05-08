//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Ray Lin on 5/5/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong)NSMutableDictionary* dictionary;

-(NSString*)imagePathForKey:(NSString*)key;

@end

@implementation BNRImageStore

+(instancetype)sharedStore{
    static  BNRImageStore* sharedStore = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc]initPrivate];
    });
    
    return sharedStore;
}

-(NSString *)imagePathForKey:(id)key{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc]init];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
    }
    return self;
}

-(void)clearCache:(NSNotification*)note{
    NSLog(@"flushing %ld images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}

-(void)setImage:(UIImage *)image forKey:(NSString *)key{
    [self.dictionary setObject:image forKey:key];
    
    NSString* imagePath = [self imagePathForKey:key];
    NSData* data = UIImagePNGRepresentation(image);
    
    [data writeToFile:imagePath atomically:YES];
}

-(UIImage *)imageForKey:(NSString *)key{
    UIImage* result = self.dictionary[key];
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        result = [UIImage imageWithContentsOfFile:imagePath];
        if (result) {
            self.dictionary[key] = result;
        }else{
            NSLog(@"unable to find %@", [self imagePathForKey:key]);
        }
    }
    return result;
}

-(void)deleteImageForKey:(NSString *)key{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    NSString* imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager]removeItemAtPath:imagePath error:nil];
}

@end
