//
//  ViewController.swift
//  Groceries
//
//  Created by Illia Akhaiev on 3/6/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import UIKit
import FMDB

final class ViewController: UITableViewController, DatabaseEngineUser {
    private var database: DatabaseEngine? = nil
    var data = [String]()
    
    func injectDatabase(_ engine: DatabaseEngine) {
        database = engine
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        database?.executeFetchBlock({ [weak self] (db) in
            let result = db.executeQuery("SELECT Groceries.Name FROM GroceriesLists INNER JOIN Groceries ON GroceriesLists.ProductID=Groceries.uid WHERE GroceriesLists.ListID=1 ORDER BY GroceriesLists.Position", withArgumentsIn: [])
            if let fetchResult = result {
                while fetchResult.next() {
                    self?.data.append(fetchResult.string(forColumn: "name")!)
                }
            }
        })
    }
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

extension ViewController {
}


