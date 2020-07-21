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

protocol HomeCategoryViewControllerDelegate: class {
    func controller(controller: HomeCategoryViewController, needPerformAction action: HomeCategoryViewController.Action)
}

final class HomeCategoryViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Properties
    enum ScrollDirection {
        case up
        case down

        var ty: CGFloat {
            switch self {
            case .up: return -500
            case .down: return 500
            }
        }
    }
    
    enum Action {
        case pushTo(vc: UIViewController)
    }

    private var viewModel = HomeCategoryViewModel()
    private var lastContentOffset: CGFloat = 0
    private var scrollDirection: ScrollDirection = .up
    weak var delegate: HomeCategoryViewControllerDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Configure.title
    }

    // MARK: - Override Functions
    override func setUpUI() {
        registerCollectionView()
        configNavi()
    }

    override func setUpData() {
        loadAPI()
    }

    // MARK: - Private Functions
    private func configNavi() {
        title = App.String.titleCountry
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    private func registerCollectionView() {
        collectionView.register(nibWithCellClass: RandomeMealCollectionViewCell.self)
        collectionView.register(nibWithCellClass: HomeCategoryCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func loadAPI() {
        HUD.show()
        viewModel.getAPIListCategory { [weak self] (done, msg) in
            HUD.dismiss()
            guard let self = self else { return }
            if done {
                self.updateView()
                let additionalTime: DispatchTimeInterval = .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime) {
                    self.loadAPIRandom()
                }
            } else {
                self.showAlert(message: msg)
            }
        }
        HUD.setOffsetFromCenter(HomeCategoryViewModel.Configure.uiOffSet)
    }

    private func loadAPIRandom() {
        viewModel.getAPIRandomMeal { [weak self] (done, error) in
            guard let self = self else { return }
            if done {
                let indexSet = IndexSet(integer: 0)
                self.collectionView.reloadSections(indexSet)
                let additionalTime: DispatchTimeInterval = .seconds(2)
                DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime) {
                    self.loadAPIRandom()
                }
            } else {
                self.showAlert(message: error)
            }
        }
    }

    private func updateView() {
        guard isViewLoaded else { return }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HomeCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withClass: RandomeMealCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.getRandomMeal(indexPath: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withClass: HomeCategoryCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.getListCategory(indexPath: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {

            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, scrollDirection.ty, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            UIView.animate(withDuration: 0.5) {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailCategoryViewController()
        let vcd = DetailMealViewController()
        if indexPath.section == 0 {
            vcd.viewModel = viewModel.pushIdMeal(indexPath: indexPath)
            delegate?.controller(controller: self, needPerformAction: .pushTo(vc: vcd))
        }
        else if indexPath.section == 1 {
            vc.viewModel = viewModel.getNameCategory(indexPath: indexPath)
            delegate?.controller(controller: self, needPerformAction: .pushTo(vc: vc))
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return HomeCategoryViewModel.Configure.sizeForCollectionRandom
        } else if indexPath.section == 1 {
            return HomeCategoryViewModel.Configure.sizeForCollection
        }
        return HomeCategoryViewModel.Configure.sizeForCollection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return HomeCategoryViewModel.Configure.spaceForCell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            // move up
            scrollDirection = .up
        }
        else if (lastContentOffset < scrollView.contentOffset.y) {
            // move down
            scrollDirection = .down
        }

        // update the new position acquired
        lastContentOffset = scrollView.contentOffset.y
    }
}
