//
//  ViewController.swift
//  Groceries
//
//  Created by Illia Akhaiev on 3/6/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
//    let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

extension ViewController {
}


