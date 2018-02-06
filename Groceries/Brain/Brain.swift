//
//  Brain.swift
//  Groceries
//
//  Loads data from db and produces model objects
//
//  Created by Illia Akhaiev on 12/17/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import SQLite3

protocol Brain: class {
    func updateNotificationName() -> String
    func updateNotificationChangeKey() -> String

    func fetchGroceries(_ handler: @escaping ([Product]?) -> Void)
    func fetchProducts(_ handler: @escaping ([Product]?) -> Void)
    func purchase(product: Product)
    func enqueue(product: Product)
    func createProduct(withName name: String)
}

class BrainImpl {
    private static let impl_updateNotificationName = "com.twealm.groceries.brain.update"
    private static let impl_updateNotificationChangeKey = "com.twealm.groceries.brain.update.change_key"

    private var database: Engine
    private var cache: Cache

    init(withEngine engine: Engine, cache: Cache) {
        database = engine
        self.cache = cache
    }

    private func phrase(for param: DatabaseAction) -> String {
        return param.rawValue
    }

    private func reportChange(change: ChangeType) {
        let name = NSNotification.Name(updateNotificationName())
        let userInfo = [updateNotificationChangeKey(): change]
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
        }
    }
}

// Fetch
extension BrainImpl: Brain {
    func updateNotificationName() -> String {
        return BrainImpl.impl_updateNotificationName
    }

    func updateNotificationChangeKey() -> String {
        return BrainImpl.impl_updateNotificationChangeKey
    }

    func fetchGroceries(_ handler: @escaping ([Product]?) -> Void) {
        let query = phrase(for: .testFetch)
        database.executeFetchBlock({ db in
            let temp = db.executeQuery(query, withArgumentsIn: [])

            guard let result = temp else {
                print("Fetch error. Got \(db.lastErrorMessage())")
                return
            }

            let products = Interpreter.interpretProducts(result)
            handler(products)
        })
    }

    func fetchProducts(_ handler: @escaping ([Product]?) -> Void) {
        let query = phrase(for: .testProductsFetch)
        database.executeFetchBlock { db in
            let temp = db.executeQuery(query, withArgumentsIn: [])

            guard let result = temp else {
                print("Fetch error. Got \(db.lastErrorMessage())")
                return
            }

            let products = Interpreter.interpretProducts(result)
            handler(products)
        }
    }

    func purchase(product: Product) {
        let query = phrase(for: .testDelete)
        database.executeUpdateBlock { [weak self] db in
            _ = db.executeUpdate(query, withArgumentsIn: [product.uid])
            self?.reportChange(change: .groceries)
        }
    }

    func enqueue(product: Product) {
        let query = phrase(for: .testEnqueue)
        database.executeUpdateBlock { [weak self] db in
            _ = db.executeUpdate(query, withArgumentsIn: [1, product.uid])
            self?.reportChange(change: .groceries)
        }
    }

    func createProduct(withName name: String) {
        if cache.containsProduct(withName: name) {
            return
        }
        
        let query = phrase(for: .testInsert)
        database.executeUpdateBlock { [weak self] db in
            _ = db.executeUpdate(query, withArgumentsIn: [name])
            self?.reportChange(change: .products)
        }
    }
}
