//
//  DetailCategoryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/23/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class DetailCategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var nameMealView: UIView!
    @IBOutlet private weak var viewForCell: UIView!
    @IBOutlet private weak var thumbnailMealImageView: UIImageView!

    var viewModel: DetailCategoryCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewForCell.layer.cornerRadius = 10
        viewForCell.clipsToBounds = true
        nameMealLabel.layer.cornerRadius = 10
        nameMealLabel.clipsToBounds = true
    }

    // MARK: - Private functions
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        nameMealLabel.text = viewModel.nameMeal
        thumbnailMealImageView.sd_setImage(with: URL(string: viewModel.urlThumnailMeal))
    }

}
