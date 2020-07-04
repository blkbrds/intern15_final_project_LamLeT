//
//  HomeCountryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SideMenu

final class CountryViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel = CountryViewModel()
    var menu: SideMenuNavigationController?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        configNavi()
        sideMenu()
    }

    override func setUpUI() {
        configNavi()
        sideMenu()
    }

    override func setUpData() {
        registerColletionCell()
        loadAPI()
    }

    // MARK: Private Funtions
    private func loadAPI() {
        HUD.show()
        viewModel.getAPIListArea { [weak self] (done, msg) in
            guard let self = self else { return }
            HUD.dismiss()
            if done {
                self.updateView()
            } else {
                self.showAlert(message: msg)
            }
        }
        HUD.setOffsetFromCenter(CountryViewModel.Configure.uiOffSet)
    }

    private func configNavi() {
        title = App.String.titleCountry
        navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(leftBarButtonTouchUpInside))
    }

    @objc func leftBarButtonTouchUpInside() {
        guard let menu = menu else { return }
        present(menu, animated: true, completion: nil)
        HUD.setOffsetFromCenter(CountryViewModel.Configure.uiOffSet)
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

    private func sideMenu() {
        let vc = SideMenuTableViewController()
        vc.delegate = self
        menu = SideMenuNavigationController(rootViewController: vc)
        guard let menu = menu else { return }
        menu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu.setNavigationBarHidden(true, animated: true)
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
        return CountryViewModel.Configure.sizeForCollection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return CountryViewModel.Configure.spaceForCell
    }
}


extension CountryViewController: SideMenuTableViewDelegate {
    func pushToLocationMenu(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
        guard let menu = menu else { return }
        menu.dismiss(animated: true, completion: nil)
    }
}
