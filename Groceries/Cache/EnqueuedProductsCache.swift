//
//  EnqueuedProductsCache.swift
//  Groceries
//
//  Created by Illia Akhaiev on 2/27/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

protocol EnqueuedProductsCache {
    var enqueuedProducts: [Product] { get }
    func didEnqueue(_ product: Product) -> Bool
}

protocol UpdatableEnqueuedProductsCache {
    func updateEnqueuedProducts(_ products: [Product]) -> Bool
}

final class EnqueuedProductsCacheImpl: EnqueuedProductsCache {
    private var storage = [Product]()

    var enqueuedProducts: [Product] {
        return storage
    }

    func didEnqueue(_ product: Product) -> Bool {
        return storage.contains(where: { $0.uid == product.uid })
    }
}

extension EnqueuedProductsCacheImpl: UpdatableEnqueuedProductsCache {
    func updateEnqueuedProducts(_ products: [Product]) -> Bool {
        guard storage != products else {
            return false
        }

        storage = products
        return true
    }
}
