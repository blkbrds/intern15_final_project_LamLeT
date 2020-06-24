//
//  HomeCategoryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class HomeCategoryViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var listCategoryCollectionView: UICollectionView!
    private var viewModel = HomeCategoryViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Category"
    }

    // MARK: - Override Functions
    override func setUpUI() {
        registerCollectionView()
    }

    override func setUpData() {
        loadAPI()
    }

    // MARK: - Private Functions
    private func registerCollectionView() {
        let nib = UINib(nibName: "HomeCategoryCollectionViewCell", bundle: .main)
        listCategoryCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        listCategoryCollectionView.dataSource = self
        listCategoryCollectionView.delegate = self
    }

    private func loadAPI() {
        viewModel.getAPIListCategory { (done, msg) in
            if done {
                self.updateView()
            } else {
                print("Failed to load")
            }
        }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.indexPath = indexPath
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
}

// MARK: - Download Image
extension HomeCategoryViewController: HomeCategoryCollectionViewCellDelegate {
    func downloadImageForCell(indexPath: IndexPath) {
        viewModel.downloadImage(at: indexPath) { (indexPath, image) in
            if let _ = image {
                self.listCategoryCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
}
