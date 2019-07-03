//
//  ProductsListViewController.swift
//  Groceries
//
//  Created by Illia Akhaiev on 6/16/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

import UIKit

final class ProductsListViewController: UIViewController {
    private let collectionView: UICollectionView
    private let layout: UICollectionViewFlowLayout
    private var products = [String]()

    init() {
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureFlowLayout()
        configureSubviewsLayout()
        view.backgroundColor = ProductsListViewStyle.backgroundColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }

    private func configureCollectionView() {
        collectionView.register(cellClass: ProductsListCollectionViewCell.self)
        collectionView.preservesSuperviewLayoutMargins = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = ProductsListViewStyle.collectionViewBackgroundColor
        collectionView.showsVerticalScrollIndicator = false
    }

    private func configureFlowLayout() {
        layout.minimumLineSpacing = ProductsListViewStyle.flowLayoutLineSpacing
    }

    private func configureSubviewsLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.addConstraints([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductsListViewController: UICollectionViewDelegate {}

extension ProductsListViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return self.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductsListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.backgroundColor = ProductsListViewStyle.cellBackgroundColor
        cell.display(model: products[indexPath.row])
        return cell
    }
}

extension ProductsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
