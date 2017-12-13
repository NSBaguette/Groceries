//
//  Interpreter.swift
//  Groceries
//
//  Translates raw data from db into model objects.
//
//  Created by Illia Akhaiev on 12/17/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import FMDB

struct Interpreter {
    static func interpretProducts(_ fetchResult: FMResultSet, brain: Brain) -> [Product] {
        var result = [Product]()
        while fetchResult.next() {
            let name = fetchResult.string(forColumn: "name")
            let uid = fetchResult.int(forColumn: "uid")
            
            let product = Product(uid: Int(uid), name: name!, brain: brain)
            result.append(product)
        }
        
        if result.count == 0 {
            return [Product]()
        }
        
        return result
    }
}
