//
//  HomeCountryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SVProgressHUD

final class CountryViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel = CountryViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpData() {
        registerColletionCell()
    }

    // MARK: Private Funtions
    private func loadAPI() {
        HUD.show()
        viewModel.getAPIListArea { [weak self] (done, msg) in
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

    private func registerColletionCell() {
//        let nib = UINib(nibName: "CountryCollectionViewCell", bundle: .main)
//        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.register(nibWithCellClass: CountryCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateView() {
        collectionView.reloadData()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: App.String.connectAPI, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: App.String.alertAction, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension CountryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
