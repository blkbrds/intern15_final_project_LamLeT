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
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = CountryViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setUpUI() {
        configNavi()
    }

    override func setUpData() {
        registerColletionCell()
        loadAPI()
    }

    // MARK: Private Funtions
    private func loadAPI() {
        SVProgressHUD.show()
        viewModel.getAPIListArea { (done, msg) in
            SVProgressHUD.dismiss()
            if done {
                self.updateView()
            } else {
                self.showAlert(message: msg)
            }
        }
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2))
    }

    private func configNavi() {
        title = Configure.title
    }

    private func registerColletionCell() {
        let nib = UINib(nibName: Configure.nibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Configure.defineCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func updateView() {
        collectionView.reloadData()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: Configure.titleAlert, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Configure.titleAlertAction, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension CountryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Configure.defineCell, for: indexPath) as? CountryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.getListArea(indexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CountryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}

// MARK: - Define
private struct Configure {
    static let title: String = "Country"
    static let defineCell: String = "cell"
    static let nibName: String = "CountryCollectionViewCell"
    static let titleAlert = "Connect API"
    static let titleAlertAction = "Connect"
}
