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

struct Interpreter {
    static func interpretProducts(_ fetchResult: FMResultSet) -> [Product] {
        var result = [Product]()
        while fetchResult.next() {
            let name = fetchResult.string(forColumn: "name")
            let uid = fetchResult.int(forColumn: "uid")

            let product = Product(uid: Int(uid), name: name!)
            result.append(product)
        }

        if result.count == 0 {
            return [Product]()
        }

        return result
    }
}
