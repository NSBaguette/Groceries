//
//  ConsumersStorage.swift
//  Groceries
//
//  Storage for consumers. Consumers are storead as weak references in NSHashTable.
//
//  Created by Illia Akhaiev on 3/10/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

final class ConsumersStorage {
    private typealias WeakConsumerSet = NSHashTable<AnyObject>
    private let options = NSPointerFunctions.Options.weakMemory

    private var map = [ChangeType: WeakConsumerSet]()

    func objects(forKey key: ChangeType) -> [ModelConsumer]? {
        let set = map[key]

        return set?.allObjects as? [ModelConsumer]
    }

    func removeObject(_ object: ModelConsumer, forKey key: ChangeType) {
        guard let set = map[key] else {
            return
        }

        set.remove(object)
    }

    func addObject(_ object: ModelConsumer, forKey key: ChangeType) {
        var set = map[key]

        if set == nil {
            set = WeakConsumerSet(options: options)
            map[key] = set
        }

        set?.add(object as AnyObject)
    }

    subscript(key: ChangeType) -> [ModelConsumer]? {
        return objects(forKey: key)
    }
}
