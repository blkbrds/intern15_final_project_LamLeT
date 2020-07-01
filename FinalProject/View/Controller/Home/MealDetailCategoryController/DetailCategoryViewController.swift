//
//  DetailCategoryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SVProgressHUD

final class DetailCategoryViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel: DetailCategoryViewModel = DetailCategoryViewModel()
    
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
        registerTableCell()
        registerCollectionCell()
        loadAPI()
    }

    // MARK: - Private Functions
    private func configNavi() {
        title = viewModel.nameCategory
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: App.String.iconCollection), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: App.String.iconBack), style: .plain, target: self, action: #selector(backToView))
    }

    // MARK: - Action
    @objc private func collectionViewButtonTouchUpInside() {
        if isShowTableView == true {
            isShowTableView = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: App.String.iconTable), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
            collectionView.isHidden = false
            collectionView.reloadData()
        } else {
            isShowTableView = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: App.String.iconCollection), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
            collectionView.isHidden = true
            tableView.reloadData()
        }
    }
    
    @objc private func backToView() {
        self.navigationController?.popViewController(animated: true)
    }


    private func registerTableCell() {
        tableView.register(nibWithCellClass: DetailCategoryTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerCollectionCell() {
        collectionView.register(nibWithCellClass: DetailCategoryCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func loadAPI() {
        HUD.show()
        viewModel.getAPIListCategory(completion: { [weak self] (done, msg) in
            HUD.dismiss()
            guard let self = self else {
                return
            }
            if done {
                self.updateUI()
            } else {
                self.showAlert(message: msg)
            }
        })
        HUD.setOffsetFromCenter(Configure.uiOffSet)
    }

    private func updateUI() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: DetailCategoryTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DetailCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: DetailCategoryCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Configure.sizeForCellCollection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Configure.spaceForCell
    }
}

// MARK: - Define
private struct Configure {
    static let uiOffSet: UIOffset = UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2)
    static let sizeForCellCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
}
