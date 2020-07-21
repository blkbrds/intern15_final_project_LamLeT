//
//  RandomCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/16/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

class RandomCollectionViewCell: UICollectionViewCell {

    // MARK: - MARK: IBOutlet
    @IBOutlet private weak var randomMealView: UIView!
    @IBOutlet private weak var randomMealImageView: UIImageView!
    @IBOutlet private weak var nameRanodmMealLabel: UILabel!

    // MARK: - Properties
    var viewModel: RandomMealCountryViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        randomMealView.layer.cornerRadius = 10
        randomMealView.clipsToBounds = true
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameRanodmMealLabel.text = viewModel.nameMeal
        randomMealImageView.sd_setImage(with: URL(string: viewModel.urlThumbnail))
    }
}
