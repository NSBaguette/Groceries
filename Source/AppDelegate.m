//
//  AppDelegate.m
//  Groceries
//
//  Created by Illia Akhaiev on 3/4/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import "AppDelegate.h"

//TODO: Move to some kind of assembler
#import "Groceries-Swift.h"
#import "Librarian/NBGLibrarian.h"
#import "Database/NBGDatabaseEngine.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIViewController *controller;
@property (strong, nonatomic) NBGDatabaseEngine *engine;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    
    self.controller = [[ProductsListViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:self.controller];
    self.window.rootViewController = navigation;

    //TODO: Move to some kind of assembler
    NBGDatabaseEngine *engine = [[NBGDatabaseEngine alloc] initWithUrl:[NBGLibrarian databaseUrl]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
