//
//  DetailCategoryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/23/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

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
        viewModel.checkFavorites(completion: { (isExist, msg) in
            if isExist {
                let image = UIImage(systemName: "heart.fill")
                self.favoritesButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(systemName: "heart")
                self.favoritesButton.setImage(image, for: .normal)
            }
        })
    }
    
    // MARK: - IBAction
    @IBAction func favoritesButtonTouchUpInside(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        viewModel.checkFavorites(completion: { (isExist, msg) in
            if isExist {
                self.deleteFavorites()
            } else {
                self.addFavorites()
            }
        })
    }

    func addFavorites() {
        guard let viewModel = viewModel else { return }
        //guard let delegate = delegate else { return }
        viewModel.addFavorites(completion: { (done, msg) in
            if done {
                let image = UIImage(systemName: "heart.fill")
                self.favoritesButton.setImage(image, for: .normal)
            } else {
                print("Can't Add")
            }
        })
    }

    func deleteFavorites() {
        guard let viewModel = viewModel else { return }
        viewModel.deleteFavorites(completion: { (done, msg) in
            if done {
                let image = UIImage(systemName: "heart")
                self.favoritesButton.setImage(image, for: .normal)
            } else {
                print("Can't Delete")
            }
        })
    }
}
