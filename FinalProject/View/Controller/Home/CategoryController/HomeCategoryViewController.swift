//
//  HomeCategoryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SVProgressHUD

final class HomeCategoryViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var listCategoryCollectionView: UICollectionView!
    private var viewModel = HomeCategoryViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Configure.title
    }

    // MARK: - Override Functions
    override func setUpUI() {
        registerCollectionView()
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    override func setUpData() {
        loadAPI()
    }

    // MARK: - Private Functions
    private func registerCollectionView() {
        let nib = UINib(nibName: Configure.nibName, bundle: .main)
        listCategoryCollectionView.register(nib, forCellWithReuseIdentifier:
                Configure.defineCell)
        listCategoryCollectionView.dataSource = self
        listCategoryCollectionView.delegate = self
    }

    private func loadAPI() {
        HUD.show()
        viewModel.getAPIListCategory { [weak self] (done, msg) in
            HUD.dismiss()
            guard let self = self else {
                return
            }
            if done {
                self.updateView()
            } else {
                self.showAlert(message: msg)
            }
        }
        HUD.setOffsetFromCenter(UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2))
    }

    private func updateView() {
        listCategoryCollectionView.reloadData()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: App.String.connectAPI, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: App.String.alertAction, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Configure.defineCell, for: indexPath) as? HomeCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.getListCategory(indexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailCategoryViewController()
        vc.viewModel = viewModel.getNameCategory(indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Define
private struct Configure {
    static let title: String = "Category Meal"
    static let defineCell: String = "cell"
    static let nibName: String = "HomeCategoryCollectionViewCell"
}
