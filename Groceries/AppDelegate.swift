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
    private var updater: UpdateCoordinator!
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
        updater = UpdateCoordinator(withBrain: brain)
        actor = DefaultActor(withBrain: brain)
        router = iOSRouter(withUpdater: updater, actor: actor)

        router.presentRootViewController(forWindow: window!)
        window?.makeKeyAndVisible()

        return true
    }
}
