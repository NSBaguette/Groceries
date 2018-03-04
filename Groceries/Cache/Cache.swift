//
//  Cache.swift
//  Groceries
//
//  Keeps cache of products and lists.
//
//  Created by Illia Akhaiev on 2/6/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

protocol Cache: ProductsCache, GroceriesCache {
}

final class CacheImpl {
    private let productsCache = ProductsCacheImpl()
    private let groceriesCache = GroceriesCacheImpl()

    func subscribe(clerk: Clerk) {
        clerk.subscribe(productsCache, for: productsCache.interests())
        clerk.notify(about: productsCache.interests())

        clerk.subscribe(groceriesCache, for: groceriesCache.interests())
        clerk.notify(about: groceriesCache.interests())
    }
}

extension CacheImpl: Cache {
    func getGroceries() -> [Product] {
        return groceriesCache.getGroceries()
    }

    func containsGrocery(grocery: Product) -> Bool {
        return groceriesCache.containsGrocery(grocery: grocery)
    }

    func getProducts() -> [Product] {
        return productsCache.getProducts()
    }

    func containsProduct(product: Product) -> Bool {
        return productsCache.containsProduct(product: product)
    }

    func containsProduct(withName name: String) -> Bool {
        return productsCache.containsProduct(withName: name)
    }

    func getProduct(withName name: String) -> Product? {
        return productsCache.getProduct(withName: name)
    }
}
