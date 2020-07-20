//
//  DetailCategoryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/23/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class DetailCategoryCollectionViewCell: UICollectionViewCell {

    private struct Configure {
        static let radius: CGFloat = 10
    }

    // MARK: - IBOutlets
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
        viewForCell.cornerRadius = Configure.radius
        nameMealLabel.cornerRadius = Configure.radius
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
