//
//  SelectableProductCell.swift
//  Groceries
//
//  Created by Illia Akhaiev on 3/5/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import UIKit

enum SelectableProductCellState {
    case selected
    case notSelected
}

final class SelectableProductCell: UITableViewCell {
    @IBOutlet var checkmark: UIImageView!
    @IBOutlet var titleLabel: UILabel!

    private var state: SelectableProductCellState = .notSelected

    override func awakeFromNib() {
        checkmark?.image = #imageLiteral(resourceName: "checkmark-empty")
    }

    func updateState(to value: SelectableProductCellState) {
        guard state != value else {
            return
        }

        state = value
        updateInterface()
    }

    private func updateInterface() {
        checkmark?.image = checkmarkImage(for: state)
    }

    private func checkmarkImage(for state: SelectableProductCellState) -> UIImage {
        switch state {
        case .selected:
            return #imageLiteral(resourceName: "checkmark-selected")
        case .notSelected:
            return #imageLiteral(resourceName: "checkmark-empty")
        }
    }
}

extension SelectableProductCell {
    static func nib() -> UINib? {
        return UINib(nibName: "SelectableProductCell", bundle: nil)
    }

    static func reuseId() -> String {
        return "SelectableProductCell"
    }
}
