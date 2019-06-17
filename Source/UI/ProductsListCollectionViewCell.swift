//
//  ProductsListCollectionViewCell.swift
//  Groceries
//
//  Created by Illia Akhaiev on 6/16/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

import UIKit

struct ProductListCellModel {
    let title: String

    init(product: NBGProduct) {
        title = product.name
    }

    private init(title: String) {
        self.title = title
    }

    static func errorModel() -> ProductListCellModel {
        return ProductListCellModel(title: "DAS ERROR")
    }
}

final class ProductsListCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviewsLayout()
        applyStyle()
    }

    func display(model: ProductListCellModel) {
        titleLabel.text = model.title
    }

    private func configureSubviewsLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        contentView.addConstraints([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }

    private func applyStyle() {
        backgroundColor = ProductsListViewStyle.backgroundColor
        titleLabel.textColor = ProductsListViewStyle.cellTitleColor
    }

    // MARK: - DEAD CODE
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
