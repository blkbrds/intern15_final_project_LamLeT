//
//  DetailCategoryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/23/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

// MARK: - Define
private struct Configure {
    static let radius: CGFloat = 10
}

final class DetailCategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var nameMealView: UIView!
    @IBOutlet private weak var viewForCell: UIView!
    @IBOutlet private weak var thumbnailMealImageView: UIImageView!
    @IBOutlet weak var favoritesButton: UIButton!

    // MARK: - Properties
    var viewModel: DetailCategoryCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewForCell.cornerRadius = Configure.radius
        nameMealLabel.cornerRadius = Configure.radius
    }

    // MARK: - Private functions
    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameMealLabel.text = viewModel.nameMeal
        thumbnailMealImageView.sd_setImage(with: URL(string: viewModel.urlThumnailMeal))
        viewModel.checkFavorites(completion: { [weak self] (isExist, msg) in
            guard let this = self else { return }
            if isExist {
                let image = UIImage(systemName: "heart.fill")
                this.favoritesButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(systemName: "heart")
                this.favoritesButton.setImage(image, for: .normal)
            }
        })
    }

    // MARK: - IBAction
    @IBAction func favoritesButtonTouchUpInside(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        viewModel.checkFavorites(completion: { [weak self] (isExist, msg) in
            guard let this = self else { return }
            if isExist {
                this.deleteFavorites()
            } else {
                this.addFavorites()
            }
        })
    }

    private func addFavorites() {
        guard let viewModel = viewModel else { return }
        viewModel.addFavorites(completion: { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                let image = UIImage(systemName: "heart.fill")
                this.favoritesButton.setImage(image, for: .normal)
            } else {
                print("Can't Add")
            }
        })
    }

    private func deleteFavorites() {
        guard let viewModel = viewModel else { return }
        viewModel.deleteFavorites(completion: { [weak self] (done, msg) in
             guard let this = self else { return }
            if done {
                let image = UIImage(systemName: "heart")
                this.favoritesButton.setImage(image, for: .normal)
            } else {
                print("Can't Delete")
            }
        })
    }
}
