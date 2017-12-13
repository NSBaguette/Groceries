//
//  UpdateCoordinator.swift
//  Groceries
//
//  Created by Illia Akhaiev on 1/28/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

enum ChangeType: String {
    case groceries = "update.groceries"
    case products = "create.product"
}

final class UpdateCoordinator {
    private var controllers = [ChangeType: [ModelConsumer]]()
    private var brain: Brain! = nil
    
    init(withBrain brain: Brain) {
        self.brain = brain
        
        let name = NSNotification.Name(Brain.updateNotificationName)
        NotificationCenter.default.addObserver(self, selector: #selector(mailbox), name: name, object: nil)
    }
    
    @objc func mailbox(notification: NSNotification) {
        if let change = notification.userInfo?[Brain.updateNotificationChangeKey] as? ChangeType {
            notify(aboutChange: change)
        }
    }
    
    func subscribe(controller: ModelConsumer, for change: ChangeType) {
        var array = controllers[change]
        if array == nil {
            array = [ModelConsumer]()
        }
        
        array?.append(controller)
        controllers[change] = array
    }
    
    func notify(aboutChange change: ChangeType) {
        switch change {
        case .groceries:
            notifyAboutGroceriesUpdate()
        case .products:
            notifyAboutProductsUpdate()
        }
    }
    
    private func notifyAboutGroceriesUpdate() {
        guard let controllers = self.controllers[.groceries] else {
            return
        }
        
        brain.fetchGroceries { (result) in
            guard let products = result else {
                return
            }
            
            DispatchQueue.main.async {
                for target in controllers {
                    target.consume(products)
                }
            }
        }
    }
    
    private func notifyAboutProductsUpdate() {
        guard let controllers = self.controllers[.products] else {
            return
        }

        brain.fetchProducts { (result) in
            guard let products = result else {
                return
            }
            
            DispatchQueue.main.async {
                for target in controllers {
                    target.consume(products)
                }
            }
        }
    }
}
