//
//  Interpreter.swift
//  Groceries
//
//  Translates raw data from db into model objects.
//
//  Created by Illia Akhaiev on 12/17/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import FMDB
import Foundation

enum ProductFields: String {
    case name
    case uid
    case enqueued
}

struct Interpreter {
    static func interpretProducts(_ fetchResult: FMResultSet) -> [Product] {
        var result = [Product]()
        while fetchResult.next() {
            guard
                let name = fetchResult.string(for: .name),
                let uid = fetchResult.int(for: .uid),
                let enqueued = fetchResult.bool(for: .enqueued) else {
                continue
            }

            let product = Product(uid: uid, name: name, enqueued: enqueued)
            result.append(product)
        }

        if result.count == 0 {
            return [Product]()
        }

        return result
    }
}

extension FMResultSet {
    func string(for field: ProductFields) -> String? {
        return string(forColumn: field.rawValue)
    }

    func int(for field: ProductFields) -> Int? {
        let value = int(forColumn: field.rawValue)
        return Int(value)
    }

    func bool(for field: ProductFields) -> Bool? {
        return bool(forColumn: field.rawValue)
    }
}
