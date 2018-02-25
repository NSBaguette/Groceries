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

protocol Cache {
    func getProducts() -> [Product]
    func containsProduct(product: Product) -> Bool
    func containsProduct(withName: String) -> Bool
    func getProduct(withName: String) -> Product?
}

final class CacheImpl {
    private var products = [Product]()
}

extension CacheImpl: ModelConsumer {
    func interests() -> ChangeType {
        return .products
    }

    func consume(_ model: [Any]) {
        if let result = model as? [Product] {
            products.removeAll()
            products.append(contentsOf: result)
        }
    }
}

extension CacheImpl: Cache {
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
}
