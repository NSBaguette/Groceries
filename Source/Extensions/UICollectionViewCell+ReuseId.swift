//
//  UICollectionViewCell+ReuseId.swift
//  Groceries
//
//  Created by Illia Akhaiev on 6/16/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

import UIKit

protocol ReusableView: AnyObject {
    static var reuseId: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var reuseId: String { return String(describing: self) }
}

extension UICollectionView {
    func dequeueReusableCell<T: ReusableView>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as! T
    }

    func register(cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
    }
}
