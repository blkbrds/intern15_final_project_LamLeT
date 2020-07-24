//
//  FavoritesTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/4/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

// MARK: - Define
private struct Configure {
    static let cornerRadius: CGFloat = 10
}

final class FavoritesTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var mealFatoritesView: UIView!
    @IBOutlet private weak var mealNameLabel: UILabel!
    @IBOutlet private weak var mealFavoriteImageView: UIImageView!

    //MARK: - Properties
    var viewModel: FavoritesTableViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        mealFatoritesView.cornerRadius = Configure.cornerRadius
        mealNameLabel.cornerRadius = Configure.cornerRadius
    }

    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        mealNameLabel.text = viewModel.nameMeal
        mealFavoriteImageView.sd_setImage(with: URL(string: viewModel.urlImageMeal))
    }
}
