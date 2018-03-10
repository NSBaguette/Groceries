//
//  WeakMap.swift
//  Groceries
//
//  Wrapper around NSMapTable that stores keys as strong references, and values
//  as weak. Also provides subscript.
//
//  Created by Illia Akhaiev on 3/10/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

final class WeakMap {
    private typealias Container = NSMapTable<AnyObject, AnyObject>
    
    private let keyOption = NSPointerFunctions.Options.strongMemory
    private let valueOption = NSPointerFunctions.Options.weakMemory
    
    private var storage: Container
    
    init() {
        storage = Container(keyOptions: keyOption, valueOptions: valueOption)
    }
    
    subscript(key: AnyObject) -> AnyObject? {
        get {
            return storage.object(forKey: key)
        }
        
        set {
            if newValue != nil {
                storage.setObject(newValue, forKey: key)
            } else {
                storage.removeObject(forKey: key)
            }
        }
    }
}
