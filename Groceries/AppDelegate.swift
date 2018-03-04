//
//  AppDelegate.swift
//  Groceries
//
//  Created by Illia Akhaiev on 3/6/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var brain: Brain!
    private var clerk: CancellableClerk!
    private var router: Router!
    private var actor: Actor!
    private var engine: Engine!
    private var cache: Cache!

    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let path = Librarian.databasePath()
        engine = FMDBDatabaseEngine(with: path)
        cache = CacheImpl()
        brain = BrainImpl(withEngine: engine, cache: cache)
        clerk = ClerkImpl(withBrain: brain)
        actor = ActorImpl(withBrain: brain)
        router = iOSRouter(withClerk: clerk, actor: actor)

        if let object = cache as? CacheImpl {
            object.subscribe(clerk: clerk)
        }

        router.presentRootViewController(forWindow: window!)
        window?.makeKeyAndVisible()

        return true
    }
}
