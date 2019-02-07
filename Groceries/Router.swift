//
//  Router.swift
//  Groceries
//
//  Knows about Brain and view controllers. Presents view controllers
//
//  Created by Illia Akhaiev on 12/12/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import UIKit

protocol RoutePleader {
    func injectRouter(_ presenter: Router)
}

protocol Router {
    init(withClerk: Clerk, actor: Actor)

    func presentController(withId: String, pleader: UIViewController)

    func presentRootViewController(forWindow window: UIWindow)

    func presentProductSelectionScreen(pleader: UIViewController)
}

struct iOSRouter: Router {
    private var clerk: Clerk
    private var actor: Actor

    init(withClerk clerk: Clerk, actor: Actor) {
        self.init(clerk: clerk, actor: actor)
    }

    internal init(clerk: Clerk, actor: Actor) {
        self.clerk = clerk
        self.actor = actor
    }

    func presentRootViewController(forWindow window: UIWindow) {
        let controller = createGroceriesController()
        let navController = UINavigationController(rootViewController: controller)
        window.rootViewController = navController
    }

    func presentProductSelectionScreen(pleader: UIViewController) {
        let controller = SelectProductViewController(style: .plain)
        configure(controller)

        let navController = UINavigationController(rootViewController: controller)
        pleader.present(navController, animated: true, completion: nil)
    }

    func presentController(withId _: String, pleader _: UIViewController) {
        // TODO: find out do you need it.
    }

    private func createGroceriesController() -> UIViewController {
        let controller = ViewController(style: .grouped)
        configure(controller)

        return controller
    }

    func configure(_ controller: UIViewController) {
        if let pleader = controller as? RoutePleader {
            pleader.injectRouter(self)
        }

        if let consumer = controller as? ModelConsumer {
            clerk.subscribe(consumer: consumer, for: consumer.interests())
            clerk.notify(aboutChange: consumer.interests())
        }

        if let pleader = controller as? ActionPleader {
            pleader.injectActor(actor)
        }
    }
}
