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
        listCategoryCollectionView.register(nibWithCellClass: HomeCategoryCollectionViewCell.self)
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
        HUD.setOffsetFromCenter(Configure.uiOffSet)
    }

    private func updateView() {
        listCategoryCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HomeCategoryCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.getListCategory(indexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Configure.sizeForCollection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Configure.spaceForCell
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
    static let uiOffSet: UIOffset = UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2)
    static let sizeForCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
}
