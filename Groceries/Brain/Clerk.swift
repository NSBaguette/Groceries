//
//  Clerk.swift
//  Groceries
//
//  Keeps tabs about changes and notifies intereseted parties.
//
//  Created by Illia Akhaiev on 1/28/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

enum ChangeType: String {
    case groceries = "update.groceries"
    case products = "create.product"
}

protocol ModelConsumer: class {
    func consume(_ model: [Any])
    func interests() -> ChangeType
}

protocol MortalModelConsumer: ModelConsumer {
    func injectMortician(_ mortician: Mortician)
}

protocol Clerk {
    func subscribe(_ consumer: ModelConsumer, for change: ChangeType)
    func notify(aboutChange change: ChangeType)
}

protocol Mortician: class {
    func remove(_ consumer: ModelConsumer, for change: ChangeType)
}

protocol CancellableClerk: Clerk, Mortician {
}

final class ClerkImpl {
    private var controllers = [ChangeType: [ModelConsumer]]()
    private var brain: Brain!

    init(withBrain brain: Brain) {
        self.brain = brain

        let name = NSNotification.Name(brain.updateNotificationName())
        NotificationCenter.default.addObserver(self, selector: #selector(mailbox), name: name, object: nil)
    }
}

extension ClerkImpl: Clerk {
    func subscribe(_ consumer: ModelConsumer, for change: ChangeType) {
        var array = controllers[change]
        if array == nil {
            array = [ModelConsumer]()
        }

        array?.append(consumer)
        controllers[change] = array
    }

    func notify(aboutChange change: ChangeType) {
        switch change {
        case .groceries:
            notifyAboutGroceriesUpdate()
        case .products:
            notifyAboutProductsUpdate()
        }
    }
}

extension ClerkImpl: CancellableClerk {
    func remove(_ consumer: ModelConsumer, for change: ChangeType) {
        var array = controllers[change]
        if let index = array?.index(where: { $0 === consumer }) {
            array?.remove(at: index)
            controllers[change] = array
        }
    }
}

extension ClerkImpl {
    @objc func mailbox(notification: NSNotification) {
        if let change = notification.userInfo?[brain.updateNotificationChangeKey()] as? ChangeType {
            notify(aboutChange: change)
        }
    }

    private func notifyAboutGroceriesUpdate() {
        guard let controllers = self.controllers[.groceries] else {
            return
        }

        brain.fetchGroceries { result in
            guard let products = result else {
                return
            }

            DispatchQueue.main.async {
                for target in controllers {
                    target.consume(products)
                }
            }
        }
    }

    private func notifyAboutProductsUpdate() {
        guard let controllers = self.controllers[.products] else {
            return
        }

        brain.fetchProducts { result in
            guard let products = result else {
                return
            }

            DispatchQueue.main.async {
                for target in controllers {
                    target.consume(products)
                }
            }
        }
    }
}
