//
//  GroceriesCache.swift
//  Groceries
//
//  Created by Illia Akhaiev on 2/27/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

protocol GroceriesCache {
    func getGroceries() -> [Product]
    func containsGrocery(grocery: Product) -> Bool
}

final class GroceriesCacheImpl: GroceriesCache {
    private var groceries = [Product]()

    func getGroceries() -> [Product] {
        return groceries
    }

    func containsGrocery(grocery: Product) -> Bool {
        return groceries.contains(where: { $0.uid == grocery.uid })
    }
}

extension GroceriesCacheImpl: ModelConsumer {
    func interests() -> Interests {
        return .groceries
    }

    func consume(_ model: [Any], change _: ChangeType) {
        if let result = model as? [Product] {
            groceries.removeAll()
            groceries.append(contentsOf: result)
        }
    }
}
