//
//  DetailMealAreaViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/24/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SVProgressHUD

final class DetailMealCountryViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel: DetailMealCountryViewModel = DetailMealCountryViewModel()
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
        loadAPI()
    }

    // MARK: - Private Functions
    private func loadAPI() {
        SVProgressHUD.show()
        viewModel.getAPIListArea(detailAreaCompletion: { (done, msg) in
            SVProgressHUD.dismiss()
            if done {
                self.updateUI()
            } else {
                self.showAlert(message: msg)
            }
        })
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2))
    }

    private func configNavi() {
        title = viewModel.nameArea
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

    private func updateUI() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailMealCountryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configure.defineCell, for: indexPath) as! DetailCategoryTableViewCell
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMealViewController()
        vc.viewModel = viewModel.pushIdMeal(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionDataSource, UICollectionDataSource
extension DetailMealCountryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Configure.defineCell, for: indexPath) as! DetailCategoryCollectionViewCell
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailMealViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailMealCountryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
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
