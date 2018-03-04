//
//  ProductSelectionViewController.swift
//  Groceries
//
//  Created by Illia Akhaiev on 12/12/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import UIKit

final class SelectProductViewController: UITableViewController {
    typealias ModelItemType = [Product]

    private let cellId = "cell"
    private var router: Router?
    private var actor: Actor?
    private weak var mortician: Mortician?

    private var data = [Product]()
    private var searchText: String?

    private var searchBar: UISearchBar?
    private var searchResultsScreen: UITableViewController?
    private var searchController: UISearchController?

    private var doneButton: UIBarButtonItem?
    private var addNewProductButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        constructInterface()
    }

    func constructInterface() {
        tableView.register(SelectableProductCell.self, forCellReuseIdentifier: cellId)

        var action = #selector(doneButtonAction)
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: action)
        navigationItem.rightBarButtonItem = doneButton

        action = #selector(addNewProductAction)
        addNewProductButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: action)
        navigationItem.leftBarButtonItem = addNewProductButton

        searchBar = UISearchBar()
        searchBar?.delegate = self
        navigationItem.titleView = searchBar!
//        searchResultsScreen = SearchProductsResultsController(style: .grouped)
//        searchController = UISearchController(searchResultsController: searchResultsScreen)
//        searchController?.searchResultsUpdater = self
//        searchController?.hidesNavigationBarDuringPresentation = false

//        self.definesPresentationContext = true
//        navigationItem.searchController = searchController!
    }

    @objc func doneButtonAction(sender _: Any) {
        dismiss(animated: true, completion: nil)
    }

    @objc func addNewProductAction(sender _: Any) {
        if let text = searchBar?.text {
            actor?.createProduct(name: text)
        }
    }

    deinit {
        mortician?.unsubscribe(self, for: interests())
    }
}

// MARK: UITableView

extension SelectProductViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let products = filteredData() else {
            return 0
        }

        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SelectableProductCell

        guard let product = filteredData()?[indexPath.row] else {
            return cell
        }

        let text = product.name
        let state: SelectableProductCellState = product.enqueued ? .selected : .notSelected

        cell.titleLabel.text = text
        cell.updateState(to: state)
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let product = filteredData()?[indexPath.row] else {
            return
        }

        if product.enqueued {
            actor?.dequeue(product: product)
        } else {
            actor?.enqueue(product: product)
        }
    }

    private func filteredData() -> [Product]? {
        guard let filter = searchText else {
            return data
        }

        return data.filter { $0.name.localizedCaseInsensitiveContains(filter) }
    }
}

// MARK: UISearchBarDelegate

extension SelectProductViewController: UISearchBarDelegate {
//    @available(iOS 2.0, *)
//    optional public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool // return NO to not become first responder
//
//    @available(iOS 2.0, *)
//    optional public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing
//

    public func searchBarShouldEndEditing(_: UISearchBar) -> Bool {
        return true
    }

//
//    @available(iOS 2.0, *)
//    optional public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) // called when text ends editing
//
    public func searchBar(_: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText.count > 0 ? searchText : nil
        tableView.reloadData()
    }

//
//    @available(iOS 3.0, *)
//    optional public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool // called before text changes
//
//
//    @available(iOS 2.0, *)
//    optional public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) // called when keyboard search button pressed
//
//    @available(iOS 2.0, *)
//    optional public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) // called when bookmark button pressed
//
//    @available(iOS 2.0, *)
//    optional public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) // called when cancel button pressed
//
//    @available(iOS 3.2, *)
//    optional public func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) // called when search results button pressed
//
//
//    @available(iOS 3.0, *)
//    optional public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
}

// MARK: MortalModelConsumer

extension SelectProductViewController: MortalModelConsumer {
    func consume(_ model: [Any], change _: ChangeType) {
        if let products = model as? [Product] {
            data = products
            tableView.reloadData()
        }
    }

    func interests() -> Interests {
        return .products
    }

    func injectMortician(_ mortician: Mortician) {
        self.mortician = mortician
    }
}

// MARK: RoutePleader

extension SelectProductViewController: RoutePleader {
    func injectRouter(_ router: Router) {
        self.router = router
    }
}

// MARK: ActionPleader

extension SelectProductViewController: ActionPleader {
    func injectActor(_ actor: Actor) {
        self.actor = actor
    }
}
