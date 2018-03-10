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

final class ClerkImpl {
    private var consumers = ConsumersStorage()
    private var brain: Brain!

    init(withBrain brain: Brain) {
        self.brain = brain

        let name = NSNotification.Name(brain.updateNotificationName())
        NotificationCenter.default.addObserver(self, selector: #selector(mailbox), name: name, object: nil)
    }
}

extension ClerkImpl: Clerk {
    func subscribe(_ consumer: ModelConsumer, for interests: Interests) {
        if interests.contains(.groceries) {
            addConsumer(consumer, for: .groceries)
        }

        if interests.contains(.products) {
            addConsumer(consumer, for: .products)
        }
    }

    func notify(about interests: Interests) {
        if interests.contains(.products) {
            notifyAboutProductsUpdate()
        }

        if interests.contains(.groceries) {
            notifyAboutGroceriesUpdate()
        }
    }
}

extension ClerkImpl: CancellableClerk {
    func unsubscribe(_ consumer: ModelConsumer, for interests: Interests) {
        if interests.contains(.products) {
            remove(consumer, for: .products)
        }

        if interests.contains(.groceries) {
            remove(consumer, for: .groceries)
        }
    }
}

extension ClerkImpl {
    @objc func mailbox(notification: NSNotification) {
        if let change = notification.userInfo?[brain.updateNotificationChangeKey()] as? ChangeType {
            notify(aboutChange: change)
        }
    }

    private func addConsumer(_ consumer: ModelConsumer, for change: ChangeType) {
        consumers.addObject(consumer, forKey: change)
    }

    private func remove(_ consumer: ModelConsumer, for change: ChangeType) {
        consumers.removeObject(consumer, forKey: change)
    }

    private func notify(aboutChange change: ChangeType) {
        switch change {
        case .groceries:
            notifyAboutGroceriesUpdate()
        case .products:
            notifyAboutProductsUpdate()
        }
    }

    private func notifyAboutGroceriesUpdate() {
        guard let consumers = self.consumers[.groceries] else {
            return
        }

        brain.fetchGroceries { result in
            guard let products = result else {
                return
            }

            DispatchQueue.main.async {
                consumers.forEach { $0.consume(products, change: .groceries) }
            }
        }
    }

    private func notifyAboutProductsUpdate() {
        guard let consumers = self.consumers[.products] else {
            return
        }

        brain.fetchProducts { result in
            guard let products = result else {
                return
            }

            DispatchQueue.main.async {
                consumers.forEach { $0.consume(products, change: .products) }
            }
        }
    }
}
