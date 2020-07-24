//
//  DetailCategoryTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

// MARK: - Define
private struct Configure {
    static let radius: CGFloat = 10
}

final class DetailCategoryTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var thumbnailMealImageView: UIImageView!
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var favoritesButton: UIButton!
    @IBOutlet private weak var nameMealLabel: UILabel!

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
        viewContent.cornerRadius = Configure.radius
        nameMealLabel.cornerRadius = Configure.radius
    }

    // MARK: Private Function
    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameMealLabel.text = viewModel.nameMeal
        thumbnailMealImageView.sd_setImage(with: URL(string: viewModel.urlThumnailMeal))
    }

}
