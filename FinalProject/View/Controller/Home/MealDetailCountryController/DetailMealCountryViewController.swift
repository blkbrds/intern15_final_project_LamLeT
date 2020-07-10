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

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: DetailMealCountryViewModel = DetailMealCountryViewModel()
    var isShowTableView: Bool = true

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isHidden = isShowTableView
    }

    override func setUpUI() {
        configNavi()
        registerTable()
        registerCollection()
    }

    override func setUpData() {
        loadAPI()
    }

    // MARK: - Private Functions
    private func loadAPI() {
        HUD.show()
        viewModel.getAPIListArea(detailAreaCompletion: { [weak self] (done, msg) in
            guard let self = self else { return }
            HUD.dismiss()
            if done {
                self.updateUI()
            } else {
                self.showAlert(message: msg)
            }
        })
        HUD.setOffsetFromCenter(UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2))
        HUD.setOffsetFromCenter(DetailMealCountryViewModel.Configure.uiOffSet)
    }

    private func configNavi() {
        title = viewModel.nameArea
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: DetailMealCountryViewModel.Configure.nameIconCollection), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: App.String.iconBack), style: .plain, target: self, action: #selector(backToView))
    }

    // MARK: - Action
    @objc private func collectionViewButtonTouchUpInside() {
        if isShowTableView == true {
            isShowTableView = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: DetailMealCountryViewModel.Configure.nameIconTable), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
            collectionView.isHidden = false
            collectionView.reloadData()
        } else {
            isShowTableView = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: DetailMealCountryViewModel.Configure.nameIconCollection), style: .plain, target: self, action: #selector(collectionViewButtonTouchUpInside))
            collectionView.isHidden = true
            tableView.reloadData()
        }
    }

    @objc private func backToView() {
        self.navigationController?.popViewController(animated: true)
    }

    private func registerTable() {
        tableView.register(nibWithCellClass: DetailCategoryTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerCollection() {
        collectionView.register(nibWithCellClass: DetailCategoryCollectionViewCell.self)
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
        let cell = tableView.dequeueReusableCell(withClass: DetailCategoryTableViewCell.self, for: indexPath)
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
        let cell = collectionView.dequeueReusableCell(withClass: DetailCategoryCollectionViewCell.self, for: indexPath)
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
        return DetailMealCountryViewModel.Configure.sizeForCollection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return DetailMealCountryViewModel.Configure.spaceForCell
    }
}
