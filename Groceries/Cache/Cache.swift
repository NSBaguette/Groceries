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

protocol UpdatableCache: Cache {
    func updateProducts(_ products: [Product]) -> Bool
    func updateGroceries(_ groceries: [Product]) -> Bool
}

final class CacheImpl {
    private let productsCache = ProductsCacheImpl()
    private let groceriesCache = GroceriesCacheImpl()
}

extension CacheImpl: UpdatableCache {
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

    func updateProducts(_ products: [Product]) -> Bool {
        return productsCache.updateProducts(products)
    }

    func updateGroceries(_ groceries: [Product]) -> Bool {
        return groceriesCache.updateGroceries(groceries)
    }
}
