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

class FavoritesTableViewCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var mealFatoritesView: UIView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealFavoriteImageView: UIImageView!

    // MARK: - Properties
    var viewModel: FavoritesTableViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        mealFatoritesView.layer.cornerRadius = Configure.cornerRadius
        mealNameLabel.layer.cornerRadius = Configure.cornerRadius
    }

    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        mealNameLabel.text = viewModel.nameMeal
        mealFavoriteImageView.sd_setImage(with: URL(string: viewModel.urlImageMeal))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
