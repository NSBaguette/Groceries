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
#import "ProductsFetcher.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIViewController *controller;
@property (strong, nonatomic) NBGDatabaseEngine *engine;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self constructUI];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)constructUI {
    //TODO: Move to some kind of assembler
    self.engine = [[NBGDatabaseEngine alloc] initWithUrl:[NBGLibrarian databaseUrl]];
    ProductsFetcher *productsFetcher = [[ProductsFetcher alloc] initWithDatabase:self.engine];
    
    ProductsListViewController *controller = [[ProductsListViewController alloc] init];
    controller.productsFetcher = productsFetcher;

    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window.rootViewController = navigation;
    self.controller = controller;
}
@end
