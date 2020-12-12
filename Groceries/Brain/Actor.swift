//
//  Actor.swift
//  Groceries
//
//  Resposible for all kinds of actions.
//
//  Created by Illia Akhaiev on 2/6/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

class ActorImpl: Actor {
    private let brain: Brain

    init(withBrain brain: Brain) {
        self.brain = brain
    }

    func createProduct(name: String) {
        brain.createProduct(withName: name) { [weak self] result in
            guard let product = result else {
                return
            }

            DispatchQueue.main.async {
                self?.enqueue(product: product)
            }
        }
    }

    func purchaseProduct(withId uid: ProductId) {
        brain.purchaseProduct(withId: uid)
    }

    func enqueue(product: Product) {
        brain.enqueue(product: product)
    }

    func dequeue(product: Product) {
        brain.dequeue(product: product)
    }
}
