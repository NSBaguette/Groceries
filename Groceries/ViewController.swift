//
//  ViewController.swift
//  Groceries
//
//  Created by Illia Akhaiev on 3/6/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import UIKit
import FMDB

final class ViewController: UITableViewController, ModelConsumer, PresentationPleader {
    
    private var addItemButton: UIBarButtonItem? = nil
    private var data = [Product]()
    private var presenter: Presenter? = nil

    func consume(_ model: [Any]) {
        if let products = model as? [Product] {
            data = products
            tableView.reloadData()
        }
    }
    
    func injectPresenter(_ presenter: Presenter) {
        self.presenter = presenter
    }
    
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
    }
    
    @objc func addItemButtonPressed(sender: Any) {
        presenter?.presentProductSelectionScreen(pleader: self)
    }
}

// Table view data source
extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
}

// Table view delegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let product = data[indexPath.row]
        product.purchase()
    }
}
