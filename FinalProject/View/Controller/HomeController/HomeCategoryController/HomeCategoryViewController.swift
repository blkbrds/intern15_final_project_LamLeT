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
    @IBOutlet weak var listCategoryCollectionView: UICollectionView!

    var dummy: [String] = ["Derest", "Breakfast", "Beef", "Chicken", "Lamb"]

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Override Functions
    override func setUpUI() {
        registerCollectionView()
    }

    override func setUpData() {

    }
    
    // MARK: - Private Functions
    private func registerCollectionView() {
        let nib = UINib(nibName: "HomeCategoryCollectionViewCell", bundle: .main)
        listCategoryCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        listCategoryCollectionView.dataSource = self
        listCategoryCollectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.name = dummy[indexPath.row]
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
