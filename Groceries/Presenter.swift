//
//  Presenter.swift
//  Groceries
//
//  Knows about Brain and view controllers. Presents view controllers
//
//  Created by Illia Akhaiev on 12/12/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import UIKit

protocol PresentationPleader {
    func injectPresenter(_ presenter: Presenter)
}

protocol Presenter {
    init(withBrain: Brain, updater: UpdateCoordinator)

    func getBrain() -> Brain

    func presentController(withId: String, pleader: UIViewController)

    func presentRootViewController(forWindow window: UIWindow)

    func presentProductSelectionScreen(pleader: UIViewController)
}

struct iOSPresenter: Presenter {
    private var brain: Brain
    private var updater: UpdateCoordinator

    init(withBrain: Brain, updater: UpdateCoordinator) {
        self.init(brain: withBrain, updater: updater)
    }

    internal init(brain: Brain, updater: UpdateCoordinator) {
        self.brain = brain
        self.updater = updater
    }

    func getBrain() -> Brain {
        return brain
    }

    func presentRootViewController(forWindow window: UIWindow) {
        let controller = createGroceriesController()
        let navController = UINavigationController(rootViewController: controller)
        window.rootViewController = navController
    }

    func presentProductSelectionScreen(pleader: UIViewController) {
        let controller = SelectProductViewController(style: .plain)
        configure(controller)
        updater.subscribe(controller: controller, for: .products)
        updater.notify(aboutChange: .products)

        let navController = UINavigationController(rootViewController: controller)
        pleader.present(navController, animated: true, completion: nil)
    }

    func presentController(withId _: String, pleader _: UIViewController) {
        // TODO: find out do you need it.
    }

    private func createGroceriesController() -> UIViewController {
        let controller = ViewController(style: .grouped)
        configure(controller)

        updater.subscribe(controller: controller, for: .groceries)
        updater.notify(aboutChange: .groceries)

        return controller
    }

    func configure(_ controller: UIViewController) {
        if let pleader = controller as? PresentationPleader {
            pleader.injectPresenter(self)
        }
    }
}
