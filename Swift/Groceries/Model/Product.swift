//
//  Product.swift
//  Groceries
//
//  Represents Product object
//
//  Created by Illia Akhaiev on 12/17/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation

struct Product {
    private(set) var uid: Int
    private(set) var name: String
    private(set) var enqueued: Bool

    init(uid: Int, name: String, enqueued: Bool) {
        self.uid = uid
        self.name = name
        self.enqueued = enqueued
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return
            lhs.uid == rhs.uid &&
            lhs.name == rhs.name &&
            lhs.enqueued == rhs.enqueued
    }
}
