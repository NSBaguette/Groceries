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
    private var addItemButton: UIBarButtonItem?
    private var data = [Product]()
    private var router: Router?
    private var actor: Actor?

    override func viewDidLoad() {
        super.viewDidLoad()
        constructInterface()
    }

    private func constructInterface() {
        view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let action = #selector(addItemButtonPressed)
        addItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: action)
        navigationItem.rightBarButtonItem = addItemButton
        
        let version = VersionUtils.loadVersion()
        self.title = version
    }

    @objc func addItemButtonPressed(sender _: Any) {
        router?.presentProductSelectionScreen(pleader: self)
    }
}

extension ListViewController: ModelConsumer {
    func consume(_ model: [Any], change _: ChangeType) {
        if let products = model as? [Product] {
            data = products
            tableView.reloadData()
        }
    }

    func interests() -> Interests {
        return .groceries
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

// UITableViewDataSource
extension ListViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
}

// UITableViewDelegate
extension ListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let product = data[indexPath.row]
        actor?.purchaseProduct(product: product)
    }
}
