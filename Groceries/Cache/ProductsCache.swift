//
//  ProductsCache.swift
//  Groceries
//
//  Created by Illia Akhaiev on 2/27/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

protocol ProductsCache {
    func getProducts() -> [Product]
    func containsProduct(product: Product) -> Bool
    func containsProduct(withName: String) -> Bool
    func getProduct(withName: String) -> Product?
    func updateProducts(_ products: [Product]) -> Bool
}

final class ProductsCacheImpl: ProductsCache {
    private var products = [Product]()

    func getProducts() -> [Product] {
        return products
    }

    func containsProduct(product: Product) -> Bool {
        return products.contains(where: { $0.uid == product.uid })
    }

    func containsProduct(withName name: String) -> Bool {
        return products.contains(where: { $0.name == name })
    }

    func getProduct(withName name: String) -> Product? {
        let result = products.first(where: { $0.name == name })
        return result
    }

    func updateProducts(_ products: [Product]) -> Bool {
        guard self.products != products else {
            return false
        }

        self.products = products
        return true
    }
}
