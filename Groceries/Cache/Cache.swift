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

protocol Cache: ProductsCache, EnqueuedProductsCache { }
protocol UpdatableCache: Cache, UpdatableProductsCache, UpdatableEnqueuedProductsCache { }

final class CacheImpl: UpdatableCache {
    private let productsCache = ProductsCacheImpl()
    private let enqueuedProductsCache = EnqueuedProductsCacheImpl()
}

extension CacheImpl: EnqueuedProductsCache {
    var enqueuedProducts: [EnqueuedProduct] { return enqueuedProductsCache.enqueuedProducts }

    func didEnqueue(_ product: Product) -> Bool {
        return enqueuedProductsCache.didEnqueue(product)
    }
}

extension CacheImpl: ProductsCache {
    var products: [Product] { return productsCache.products }
    
    func contains(product: Product) -> Bool {
        return productsCache.contains(product: product)
    }
    
    func containsProduct(withName name: String) -> Bool {
        return productsCache.containsProduct(withName: name)
    }

    func getProduct(withName name: String) -> Product? {
        return productsCache.getProduct(withName: name)
    }
}

extension CacheImpl: UpdatableProductsCache {
    func updateProducts(_ products: [Product]) -> Bool {
        return productsCache.updateProducts(products)
    }
}

extension CacheImpl: UpdatableEnqueuedProductsCache {
    func updateEnqueuedProducts(_ products: [EnqueuedProduct]) -> Bool {
        return enqueuedProductsCache.updateEnqueuedProducts(products)
    }
}
