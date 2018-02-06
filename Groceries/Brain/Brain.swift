//
//  Brain.swift
//  Groceries
//
//  Loads data from db and produces view-model
//
//  Created by Illia Akhaiev on 12/17/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import SQLite3

protocol ModelConsumer {
    func consume(_ model: [Any])
    func interests() -> ChangeType
}

struct Brain {
    public static let updateNotificationName = "com.twealm.groceries.brain.update"
    public static let updateNotificationChangeKey = "com.twealm.groceries.brain.update.change_key"

    private var database: DatabaseEngine

    init(withEngine engine: DatabaseEngine) {
        database = engine
    }
}

// Fetch
extension Brain {
    func fetchGroceries(_ handler: @escaping ([Product]?) -> Void) {
        let query = phrase(for: .testFetch)
        database.executeFetchBlock({ db in
            let temp = db.executeQuery(query, withArgumentsIn: [])

            guard let result = temp else {
                print("Fetch error. Got \(db.lastErrorMessage())")
                return
            }

            let products = Interpreter.interpretProducts(result, brain: self)
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

            let products = Interpreter.interpretProducts(result, brain: self)
            handler(products)
        }
    }

    func purchase(product: Product) {
        let query = phrase(for: .testDelete)
        database.executeUpdateBlock { db in
            _ = db.executeUpdate(query, withArgumentsIn: [product.uid])
            BrainChangeReporter.reportChange(change: .groceries)
        }
    }

    func enqueue(product: Product) {
        let query = phrase(for: .testEnqueue)
        database.executeUpdateBlock { db in
            _ = db.executeUpdate(query, withArgumentsIn: [1, product.uid])
            BrainChangeReporter.reportChange(change: .groceries)
        }
    }

    func createProduct(withName name: String) {
        let query = phrase(for: .testInsert)
        database.executeUpdateBlock { db in
            _ = db.executeUpdate(query, withArgumentsIn: [name])
            BrainChangeReporter.reportChange(change: .products)
        }
    }
}

extension Brain {
    func phrase(for param: DatabaseAction) -> String {
        return param.rawValue
    }
}

struct BrainChangeReporter {
    static func reportChange(change: ChangeType) {
        let name = NSNotification.Name(Brain.updateNotificationName)
        let userInfo = [Brain.updateNotificationChangeKey: change]
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
        }
    }
}
