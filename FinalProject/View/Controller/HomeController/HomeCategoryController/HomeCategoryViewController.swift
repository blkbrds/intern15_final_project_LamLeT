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

    private func registerCollectionView() {
        let nib = UINib(nibName: "HomeCategoryCollectionViewCell", bundle: .main)
        listCategoryCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        listCategoryCollectionView.dataSource = self
        listCategoryCollectionView.delegate = self
    }
}

extension HomeCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }


}
