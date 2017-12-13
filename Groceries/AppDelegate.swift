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
    private var brain: Brain! = nil
    private var updater: UpdateCoordinator! = nil
    private var presenter: Presenter! = nil
    private lazy var dbEngine: DatabaseEngine = {
        let path = Librarian.databasePath()
        return FMDBDatabaseEngine(with: path)
    } ()
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        brain = Brain(withEngine: dbEngine)
        updater = UpdateCoordinator(withBrain: brain)
        presenter = iOSPresenter(withBrain: brain, updater: updater)
        
        presenter.presentRootViewController(forWindow: window!)
        window?.makeKeyAndVisible()
        
        return true
    }
}
