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
    private var brain: Brain

    init(uid: Int, name: String, brain: Brain) {
        self.uid = uid
        self.name = name
        self.brain = brain
    }
}
