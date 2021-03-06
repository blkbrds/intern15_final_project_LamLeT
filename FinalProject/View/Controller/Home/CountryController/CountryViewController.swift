//
//  HomeCountryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

// MARK: - Define
private struct Configure {
    static let sizeForCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
}

final class CountryViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Properties
    var viewModel = CountryViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        configNavi()
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
        HUD.show()
        viewModel.getAPIListArea { [weak self] (done, msg) in
            HUD.dismiss()
            guard let this = self else { return }
            if done {
                this.updateView()
            } else {
                this.showAlert(message: msg)
            }
        }
    }

    private func configNavi() {
        title = App.String.titleCountry
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    private func registerColletionCell() {
        collectionView.register(nibWithCellClass: CountryCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func updateView() {
        guard isViewLoaded else { return }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension CountryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: CountryCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel.getListArea(indexPath: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailMealCountryViewController()
        vc.viewModel = viewModel.getNameArea(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CountryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Configure.sizeForCollection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Configure.spaceForCell
    }
}
