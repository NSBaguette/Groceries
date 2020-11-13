//
//  Router.swift
//  Groceries
//
//  Knows a bit about data and everything about view controllers.
//  Presents view controllers
//
//  Created by Illia Akhaiev on 12/12/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import UIKit

struct iOSRouter: Router {
    private var clerk: CancellableClerk
    private var actor: Actor

    init(withClerk clerk: CancellableClerk, actor: Actor) {
        self.init(clerk: clerk, actor: actor)
    }

    internal init(clerk: CancellableClerk, actor: Actor) {
        self.clerk = clerk
        self.actor = actor
    }

    func presentRootViewController(forWindow window: UIWindow) {
        let controller = createProductsListController()
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

    private func createProductsListController() -> UIViewController {
        let controller = ListViewController(style: .grouped)
        configure(controller)

        return controller
    }

    func configure(_ controller: UIViewController) {
        if let pleader = controller as? RoutePleader {
            pleader.injectRouter(self)
        }

        if let consumer = controller as? ModelConsumer {
            clerk.subscribe(consumer, for: consumer.interests())
            clerk.notify(about: consumer.interests())

            if let mortal = consumer as? MortalModelConsumer {
                mortal.injectMortician(clerk)
            }
        }

        if let pleader = controller as? ActionPleader {
            pleader.injectActor(actor)
        }
    }
}
