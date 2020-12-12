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

    func fetchEnqueuedProducts(_ handler: @escaping ([EnqueuedProduct]?) -> Void)
    func fetchProducts(_ handler: @escaping ([Product]?) -> Void)
    func purchaseProduct(withId: ProductId)
    func enqueue(product: Product)
    func dequeue(product: Product)
    func createProduct(withName name: String, _ handler: @escaping (Product?) -> Void)
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

    private func readLastAddedProduct(_ handler: @escaping (Product?) -> Void) {
        let query = phrase(for: .testFetchLastInsertedGrocery)
        database.executeFetchBlock { db in
            guard let result = db.executeQuery(query, withArgumentsIn: []) else {
                print("Fetch error. Got \(db.lastErrorMessage())")
                BrainImpl.callback(param: nil, handler)

                return
            }

            let products = Interpreter.interpretProducts(result)
            BrainImpl.callback(param: products.first, handler)
        }
    }
}

// Database
extension BrainImpl: Brain {
    func updateNotificationName() -> String {
        return BrainImpl.impl_updateNotificationName
    }

    func updateNotificationChangeKey() -> String {
        return BrainImpl.impl_updateNotificationChangeKey
    }

    func fetchEnqueuedProducts(_ handler: @escaping ([EnqueuedProduct]?) -> Void) {
        let query = phrase(for: .testFetchEnqueuedProducts)
        database.executeFetchBlock({ db in
            let temp = db.executeQuery(query, withArgumentsIn: [])

            guard let result = temp else {
                print("Fetch error. Got \(db.lastErrorMessage())")
                BrainImpl.callback(param: nil, handler)
                return
            }

            let products = Interpreter.interpretEnqueuedProducts(result)
            BrainImpl.callback(param: products, handler)
        })
    }

    func fetchProducts(_ handler: @escaping ([Product]?) -> Void) {
        let query = phrase(for: .testFetchProducts)
        database.executeFetchBlock { db in
            let temp = db.executeQuery(query, withArgumentsIn: [])

            guard let result = temp else {
                print("Fetch error. Got \(db.lastErrorMessage())")
                BrainImpl.callback(param: nil, handler)
                return
            }

            let products = Interpreter.interpretProducts(result)
            BrainImpl.callback(param: products, handler)
        }
    }

    func purchaseProduct(withId uid: ProductId) {
        let query = phrase(for: .testPurchaseProduct)
        database.executeUpdateBlock { [weak self] db in
            _ = db.executeUpdate(query, withArgumentsIn: [uid])
            self?.reportChange(change: .enqueuedProducts)
            self?.reportChange(change: .products)
        }
    }

    func enqueue(product: Product) {
        let query = phrase(for: .testEnqueueProduct)
        database.executeUpdateBlock { [weak self] db in
            _ = db.executeUpdate(query, withArgumentsIn: [1, product.uid])
            self?.reportChange(change: .enqueuedProducts)
            self?.reportChange(change: .products)
        }
    }
    
    func dequeue(product: Product) {
        let query = phrase(for: .testDequeueProduct)
        database.executeUpdateBlock { [weak self] db in
            _ = db.executeUpdate(query, withArgumentsIn: [1, product.uid])
            self?.reportChange(change: .enqueuedProducts)
            self?.reportChange(change: .products)
        }
    }

    func createProduct(withName name: String, _ handler: @escaping (Product?) -> Void) {
        if cache.containsProduct(withName: name) {
            let product = cache.getProduct(withName: name)
            BrainImpl.callback(param: product, handler)

            return
        }

        let query = phrase(for: .testCreateNewProduct)
        database.executeUpdateBlock { [weak self] db in
            let result = db.executeUpdate(query, withArgumentsIn: [name])
            if result == false {
                print("Insert error. Got \(db.lastErrorMessage())")
                BrainImpl.callback(param: nil, handler)
                return
            }

            self?.reportChange(change: .products)
            self?.readLastAddedProduct(handler)
        }
    }
}

// Deliver result
extension BrainImpl {
    private class func callback<T>(param: T?, _ handler: @escaping (T?) -> Void) {
        DispatchQueue.main.async {
            handler(param)
        }
    }
}
