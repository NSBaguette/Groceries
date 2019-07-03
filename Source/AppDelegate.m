//
//  AppDelegate.m
//  Groceries
//
//  Created by Illia Akhaiev on 3/4/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import "AppDelegate.h"
@import CoreData;

//TODO: Move to some kind of assembler
#import "Groceries-Swift.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIViewController *controller;
@property (strong, nonatomic) NSPersistentContainer *container;
@end

@implementation AppDelegate
//@synthesize container = _container;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    __unused __weak typeof(self) weakSelf = self;
    [self loadContainer:self.container completion:^{ }];
    [self constructUI];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)constructUI {
    ProductsListViewController *controller = [[ProductsListViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window.rootViewController = navigation;
    self.controller = controller;
}

- (NSPersistentContainer *)container {
    if (_container == nil) {
        _container = [[NSPersistentContainer alloc] initWithName:@"Model"];
    }
    return _container;
}

- (void)loadContainer:(NSPersistentContainer *)container completion:(nonnull void (^)(void))completion {
    [container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull description, NSError * _Nullable error) {
        if (error) { exit(0); }
        completion();
    }];
}
@end
