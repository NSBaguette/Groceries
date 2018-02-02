//
//  ProductSearchResultsController.swift
//  Groceries
//
//  Created by Illia Akhaiev on 12/14/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import UIKit

final class SearchProductsResultsController: UITableViewController {
    private var data = [String]()
    private var doneButton: UIBarButtonItem?

    public func updateSearchResults(_ results: [String]) {
        data = results
        tableView.reloadData()
    }

    private func constructInterface() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let action = #selector(doneButtonPressed)
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: action)
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc func doneButtonPressed(sender _: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchProductsResultsController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
