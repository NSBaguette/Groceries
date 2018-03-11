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
    private var brain: Brain
    private var cache: UpdatableCache

    init(withBrain brain: Brain, cache: UpdatableCache) {
        self.brain = brain
        self.cache = cache

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

    func updateRecords() {
        updateRecords(about: .groceries)
        updateRecords(about: .products)
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
            updateRecords(about: change)
        }
    }

    private func addConsumer(_ consumer: ModelConsumer, for change: ChangeType) {
        consumers.addObject(consumer, forKey: change)
    }

    private func remove(_ consumer: ModelConsumer, for change: ChangeType) {
        consumers.removeObject(consumer, forKey: change)
    }

    private func updateRecords(about change: ChangeType) {
        switch change {
        case .groceries:
            updateGroceriesRecords(notify: true)
        case .products:
            updateProductsRecords(notify: true)
        }
    }

    private func updateGroceriesRecords(notify: Bool) {
        brain.fetchGroceries { result in
            guard let products = result else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                let changed = self?.cache.updateGroceries(products) ?? false

                if notify && changed {
                    self?.notifyAboutGroceriesUpdate()
                }
            }
        }
    }

    private func updateProductsRecords(notify: Bool) {
        brain.fetchProducts { result in
            guard let products = result else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                let changed = self?.cache.updateProducts(products) ?? false

                if notify && changed {
                    self?.notifyAboutProductsUpdate()
                }
            }
        }
    }

    private func notifyAboutGroceriesUpdate() {
        guard let consumers = self.consumers[.groceries] else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let products = self?.cache.getGroceries() else {
                return
            }

            consumers.forEach { $0.consume(products, change: .groceries) }
        }
    }

    private func notifyAboutProductsUpdate() {
        guard let consumers = self.consumers[.products] else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let products = self?.cache.getProducts() else {
                return
            }

            consumers.forEach { $0.consume(products, change: .products) }
        }
    }
}
