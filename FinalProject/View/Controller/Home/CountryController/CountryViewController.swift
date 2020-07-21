//
//  HomeCountryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

protocol CountryViewControllerDelegate: class {
    func controller(_ controller: CountryViewController, needPerformAction action: CountryViewController.Action)
}
// MARK: - Define
private struct Configure {
    static let sizeForCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    static let sizeForCollectionRandom: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)), height: 250)
}

final class CountryViewController: BaseViewController {

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
        case pushToController(vc: UIViewController)
    }

    private var lastContentOffset: CGFloat = 0
    private var scrollDirection: ScrollDirection = .up
    weak var delegate: CountryViewControllerDelegate?
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
            guard let self = self else { return }
            HUD.dismiss()
            if done {
                self.updateView()
                let additionalTime: DispatchTimeInterval = .seconds(Int(0.4))
                DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime) {
                    self.loadAPIRandom()
                }
            } else {
                self.showAlert(message: msg)
            }
        }
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

    private func configNavi() {
        title = App.String.titleCountry
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    private func registerColletionCell() {
        collectionView.register(nibWithCellClass: RandomCollectionViewCell.self)
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withClass: RandomCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.getRandomMeal(indexPath: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withClass: CountryCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.getListArea(indexPath: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vcd = DetailMealViewController()
            vcd.viewModel = viewModel.pushIdMeal(indexPath: indexPath)
            delegate?.controller(self, needPerformAction: .pushToController(vc: vcd))
        } else if indexPath.section == 1 {
            let vc = DetailMealCountryViewController()
            vc.viewModel = viewModel.getNameArea(indexPath: indexPath)
            delegate?.controller(self, needPerformAction: .pushToController(vc: vc))
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, scrollDirection.ty, 0)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5
            UIView.animate(withDuration: 1.0) {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CountryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return Configure.sizeForCollectionRandom
        } else if indexPath.section == 1 {
            return Configure.sizeForCollection
        }
        return Configure.sizeForCollection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Configure.spaceForCell
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
