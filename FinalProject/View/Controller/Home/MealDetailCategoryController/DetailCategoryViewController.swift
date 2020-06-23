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
    var viewModel: DetailCategoryViewModel?
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
        title = viewModel?.nameCategory
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_collectionView"), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
    }

    // MARK: - Action
    @objc private func collectionViewButtonTouchUpInside() {
        if isShowTableView == true {
            isShowTableView = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_tableView"), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
            collectionView.isHidden = false
            collectionView.reloadData()
        } else {
            isShowTableView = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_collectionView"), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
            collectionView.isHidden = true
            tableView.reloadData()
        }
    }


    private func registerTableCell() {
        let nib = UINib(nibName: "DetailCategoryTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerCollectionCell() {
        let nib = UINib(nibName: "DetailCategoryCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func loadAPI() {
        guard let viewModel = viewModel else {
            return
        }
        SVProgressHUD.show()
        viewModel.getAPIListCategory(detailCategoryCompletion: { (done, msg) in
            SVProgressHUD.dismiss()
            if done {
                self.updateUI()
            } else {
                self.showAlert(message: msg)
            }
        })
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2))
    }

    private func updateUI() {
        tableView.reloadData()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Connect API", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Connect", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCategoryTableViewCell
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.heightForRowAt()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DetailCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfRowsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailCategoryCollectionViewCell
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}
