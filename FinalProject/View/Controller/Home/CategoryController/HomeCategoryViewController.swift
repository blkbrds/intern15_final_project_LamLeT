//
//  HomeCategoryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SVProgressHUD
import SideMenu

final class HomeCategoryViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var listCategoryCollectionView: UICollectionView!

    // MARK: - Properties
    private var viewModel = HomeCategoryViewModel()
    var menu: SideMenuNavigationController?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = DefineHomeCategory.title
    }

    // MARK: - Override Functions
    override func setUpUI() {
        registerCollectionView()
        configNavi()
        sideMenu()
    }

    override func setUpData() {
        loadAPI()
    }

    // MARK: - Private Functions
    private func configNavi() {
        title = App.String.titleCountry
        navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(leftBarButtonTouchUpInside))
    }

    @objc func leftBarButtonTouchUpInside() {
        guard let menu = menu else { return }
        present(menu, animated: true, completion: nil)
    }

    private func sideMenu() {
        let vc = SideMenuTableViewController()
        vc.delegate = self
        menu = SideMenuNavigationController(rootViewController: vc)
        guard let menu = menu else { return }
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = UIScreen.main.bounds.width * 2 / 3
        menu.leftSide = true
        menu.setNavigationBarHidden(true, animated: false)
    }

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
    }

    private func updateView() {
        guard isViewLoaded else { return }
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
        return DefineHomeCategory.sizeForItem
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return DefineHomeCategory.spaceForCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailCategoryViewController()
        vc.viewModel = viewModel.getNameCategory(indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - SideMenuTableViewDelegate
extension HomeCategoryViewController: SideMenuTableViewDelegate {
    func pushToLocationMenu(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
        guard let menu = menu else { return }
        menu.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Define
private struct DefineHomeCategory {
    static let title: String = "Category Meal"
    static let sizeForItem: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
}
