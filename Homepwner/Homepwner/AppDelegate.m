//
//  AppDelegate.m
//  Homepwner
//
//  Created by Ray Lin on 5/3/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRItemsTableView.h"
#import "BNRImageStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BNRItemsTableView* itemsViewController = [[BNRItemsTableView alloc]init];
    
    //self.window.rootViewController = itemsViewController;
    
    UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:itemsViewController];
    self.window.rootViewController = navController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    BOOL success = [[BNRItemsStore sharedStore]saveChanges];
    if (success) {
        NSLog(@"saved all the BNRItems");
    }else{
        NSLog(@"could not save any of the BNRItems");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
