//
//  DetailMealAreaViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/24/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class DetailMealAreaViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel: DetailMealAreaViewModel?
    var isShowTableView: Bool = true

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = isShowTableView
    }

    override func setUpUI() {
        configNavi()
    }

    override func setUpData() {
        registerTable()
        registerCollection()
    }

    // MARK: - Private Functions
    private func configNavi() {
        title = viewModel?.nameArea
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: Configure.nameIconCollection), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
    }

    // MARK: - Action
    @objc private func collectionViewButtonTouchUpInside() {
        if isShowTableView == true {
            isShowTableView = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: Configure.nameIconTable), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
            collectionView.isHidden = false
            collectionView.reloadData()
        } else {
            isShowTableView = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: Configure.nameIconCollection), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
            collectionView.isHidden = true
            tableView.reloadData()
        }
    }

    private func registerTable() {
        let nib = UINib(nibName: Configure.nibNameTable, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Configure.defineCell)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerCollection() {
        let nib = UINib(nibName: Configure.nibNameCollection, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Configure.defineCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailMealAreaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UICollectionDataSource, UICollectionDataSource
extension DetailMealAreaViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

// MARK: - Define
private struct Configure {
    static let title: String = "Area Meal"
    static let defineCell: String = "cell"
    static let nibNameTable: String = "DetailCategoryTableViewCell"
    static let nibNameCollection: String = "DetailCategoryCollectionViewCell"
    static let nameIconTable: String = "icon_tableView"
    static let nameIconCollection: String = "icon_collectionView"
}
