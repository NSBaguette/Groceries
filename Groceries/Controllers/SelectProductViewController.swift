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
        tableView.register(SelectableProductCell.self, forCellReuseIdentifier: self.cellId)

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
        mortician?.remove(self, for: interests())
    }
}

extension SelectProductViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId) as! SelectableProductCell
        cell.cellTextLabel.text = data[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let product = data[indexPath.row]
        actor?.enqueue(product: product)
    }
}

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
//    @available(iOS 2.0, *)
//    optional public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
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

extension SelectProductViewController: MortalModelConsumer {
    func consume(_ model: [Any]) {
        if let products = model as? [Product] {
            data = products
            tableView.reloadData()
        }
    }

    func interests() -> ChangeType {
        return .products
    }

    func injectMortician(_ mortician: Mortician) {
        self.mortician = mortician
    }
}

extension SelectProductViewController: RoutePleader {
    func injectRouter(_ router: Router) {
        self.router = router
    }
}

extension SelectProductViewController: ActionPleader {
    func injectActor(_ actor: Actor) {
        self.actor = actor
    }
}
