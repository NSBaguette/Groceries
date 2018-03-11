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
    func updateGroceries(_ groceries: [Product]) -> Bool
}

final class GroceriesCacheImpl: GroceriesCache {
    private var groceries = [Product]()

    func getGroceries() -> [Product] {
        return groceries
    }

    func containsGrocery(grocery: Product) -> Bool {
        return groceries.contains(where: { $0.uid == grocery.uid })
    }

    func updateGroceries(_ groceries: [Product]) -> Bool {
        guard self.groceries != groceries else {
            return false
        }

        self.groceries = groceries
        return true
    }
}
