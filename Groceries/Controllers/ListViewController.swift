//
//  ViewController.swift
//  Groceries
//
//  Created by Illia Akhaiev on 3/6/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import FMDB
import UIKit

final class ListViewController: UITableViewController {
    private var addItemButton: UIBarButtonItem!
    private var shareButton: UIBarButtonItem!
    
    private var data = [EnqueuedProduct]()
    private var router: Router?
    private var actor: Actor?

    override func viewDidLoad() {
        super.viewDidLoad()
        constructInterface()
    }

    private func constructInterface() {
        view.backgroundColor = UIColor.white
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")

        let addItemHandler = #selector(addItemAction)
        addItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: addItemHandler)
        
        let shareHandler = #selector(shareAction)
        shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: shareHandler)
        
        navigationItem.rightBarButtonItems = [addItemButton, shareButton]
        
        let version = VersionUtils.loadVersion()
        self.title = version
    }

    @objc func addItemAction(sender _: Any) {
        router?.presentProductSelectionScreen(pleader: self)
    }
    
    @objc func shareAction(sender _: Any) {
        /*<<**************TEST_CODE_BEGIN**************>>*/
        // IMPLEMENT ME
        /*<<***************TEST_CODE_END***************>>*/
    }
    
    // UITableViewDataSource
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListTableViewCell
        let product = data[indexPath.row]
        
        cell.selectionStyle = .none
        cell.update(with: product.name, selected: product.purchased, completion: nil)
        
        return cell
    }
    
    // UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath) as? ListTableViewCell
        cell?.update(with: data[indexPath.row].name, selected: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let product = self.data[indexPath.row]
                self.actor?.purchaseProduct(withId: product.uid)
            }
        })
    }
}

extension ListViewController: ModelConsumer {
    func consume(_ model: [Any], change _: ChangeType) {
        if let products = model as? [EnqueuedProduct] {
            data = products
            tableView.reloadData()
        }
    }

    func interests() -> Interests {
        return .enqueuedProducts
    }
}

extension ListViewController: RoutePleader {
    func injectRouter(_ router: Router) {
        self.router = router
    }
}

extension ListViewController: ActionPleader {
    func injectActor(_ actor: Actor) {
        self.actor = actor
    }
}
