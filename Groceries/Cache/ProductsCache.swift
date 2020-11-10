//
//  ProductsCache.swift
//  Groceries
//
//  Created by Illia Akhaiev on 2/27/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

protocol ProductsCache {
    var products: [Product] { get }
    func contains(product: Product) -> Bool
    func containsProduct(withName: String) -> Bool
    func getProduct(withName: String) -> Product?
}

protocol UpdatableProductsCache {
    func updateProducts(_ products: [Product]) -> Bool
}

final class ProductsCacheImpl: ProductsCache {
    private var storage = [Product]()

    var products: [Product] { return storage }

    func contains(product: Product) -> Bool {
        return storage.contains(where: { $0.uid == product.uid })
    }

    func containsProduct(withName name: String) -> Bool {
        return storage.contains(where: { $0.name == name })
    }

    func getProduct(withName name: String) -> Product? {
        let result = storage.first(where: { $0.name == name })
        return result
    }
}

extension ProductsCacheImpl: UpdatableProductsCache {
    func updateProducts(_ products: [Product]) -> Bool {
        guard storage != products else {
            return false
        }

        storage = products
        return true
    }
}
