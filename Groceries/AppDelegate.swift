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
    private var clerk: Clerk!
    private var router: Router!
    private var actor: Actor!
    private lazy var dbEngine: DatabaseEngine = {
        let path = Librarian.databasePath()
        return FMDBDatabaseEngine(with: path)
    }()

    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        brain = Brain(withEngine: dbEngine)
        clerk = ClerkImpl(withBrain: brain)
        actor = ActorImpl(withBrain: brain)
        router = iOSRouter(withClerk: clerk, actor: actor)

        router.presentRootViewController(forWindow: window!)
        window?.makeKeyAndVisible()

        return true
    }
}
