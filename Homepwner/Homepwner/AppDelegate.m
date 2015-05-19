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

NSString * const BNRNextItemValuePrefsKey = @"NextItemValue";
NSString * const BNRNextItemNamePrefsKey = @"NextItemName";

@interface AppDelegate ()

@end

@implementation AppDelegate

+(void)initialize{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* factorySettings = @{BNRNextItemValuePrefsKey : @75, BNRNextItemNamePrefsKey : @"Coffee Cup"};
    [defaults registerDefaults:factorySettings];
}

-(UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder{
    UIViewController *vc = [[UINavigationController alloc]init];
    vc.restorationIdentifier = [identifierComponents lastObject];
    if ([identifierComponents count]==1) {
        self.window.rootViewController = vc;
    }
    return vc;
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    if (!self.window.rootViewController) {
    
    BNRItemsTableView* itemsViewController = [[BNRItemsTableView alloc]init];
    
    
    
    UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:itemsViewController];
    
    navController.restorationIdentifier = NSStringFromClass([navController class]);
    
    self.window.rootViewController = navController;
    }
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

-(BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder{
    return YES;
}
-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder{
    return YES;
}

@end
