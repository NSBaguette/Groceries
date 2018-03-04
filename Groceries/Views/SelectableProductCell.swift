//
//  SelectableProductCell.swift
//  Groceries
//
//  Created by Illia Akhaiev on 2/9/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation
import UIKit

enum SelectableProductCellState {
    case selected
    case notSelected
}

fileprivate final class SelectableProductCellInternals {
    var checkmarkOffset = UIEdgeInsets.zero
}

fileprivate final class Ruler {
    static func checkmarkOffset(from offset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, offset + 1, 0, 5)
    }
}

final class SelectableProductCell: UITableViewCell {
    private var checkmark: UIImageView = UIImageView()
    private var state: SelectableProductCellState = .notSelected
    private(set) var titleLabel = UILabel()
    private var internals = SelectableProductCellInternals()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        constructInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        constructInterface()
    }

    func updateState(to value: SelectableProductCellState) {
        guard state != value else {
            return
        }

        state = value
        updateInterface()
    }

    private func constructInterface() {
        contentView.addSubview(titleLabel)
        internals.checkmarkOffset = Ruler.checkmarkOffset(from: separatorInset.left)
        accessoryType = .detailButton

        contentView.addSubview(checkmark)
        checkmark.image = checkmarkImage(for: state)
        applyConstraints(internals: internals)
    }

    private func updateInterface() {
        checkmark.image = checkmarkImage(for: state)
    }

    private func checkmarkImage(for state: SelectableProductCellState) -> UIImage {
        switch state {
        case .selected:
            return UIImage(named: "checkmark-selected")!
        case .notSelected:
            return UIImage(named: "checkmark-empty")!
        }
    }
}

extension SelectableProductCell {
    override func updateConstraints() {
        super.updateConstraints()
    }

    private func applyConstraints(internals: SelectableProductCellInternals) {
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        var constraint = NSLayoutConstraint(item: checkmark,
                                            attribute: .centerY,
                                            relatedBy: .equal,
                                            toItem: contentView,
                                            attribute: .centerY,
                                            multiplier: 1,
                                            constant: 0)
        contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: checkmark,
                                        attribute: .left,
                                        relatedBy: .equal,
                                        toItem: contentView,
                                        attribute: .left,
                                        multiplier: 1,
                                        constant: internals.checkmarkOffset.left)
        contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: checkmark,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: contentView,
                                        attribute: .height,
                                        multiplier: 0.5,
                                        constant: 0)
        contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: checkmark,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: checkmark,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 0)
        contentView.addConstraint(constraint)

        //
        constraint = NSLayoutConstraint(item: titleLabel,
                                        attribute: .left,
                                        relatedBy: .equal,
                                        toItem: checkmark,
                                        attribute: .right,
                                        multiplier: 1,
                                        constant: internals.checkmarkOffset.right)
        contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: titleLabel,
                                        attribute: .right,
                                        relatedBy: .equal,
                                        toItem: contentView,
                                        attribute: .right,
                                        multiplier: 1,
                                        constant: 0)
        contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: titleLabel,
                                        attribute: .centerY,
                                        relatedBy: .equal,
                                        toItem: contentView,
                                        attribute: .centerY,
                                        multiplier: 1,
                                        constant: 0)
        contentView.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: titleLabel,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: contentView,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 0)
        contentView.addConstraint(constraint)
    }
}
