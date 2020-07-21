//
//  OrtherFoodTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/1/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

// MARK: - Define
private struct Configure {
    static let cornerRadius: CGFloat = 10
}

final class OtherFoodTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var otherFoodView: UIView!
    @IBOutlet private weak var otherFoodImageView: UIImageView!
    @IBOutlet private weak var nameOtherFoodLabel: UILabel!
    @IBOutlet private weak var nameOtherFoodView: UIView!
    @IBOutlet private weak var favoritesButton: UIButton!

    // MARK: - Properties
    var viewModel: OtherFoodCellViewModel = OtherFoodCellViewModel() {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        otherFoodView.layer.cornerRadius = Configure.cornerRadius
        nameOtherFoodLabel.layer.cornerRadius = Configure.cornerRadius
    }

    private func updateView() {
        nameOtherFoodLabel.text = viewModel.otherMealName
        otherFoodImageView.sd_setImage(with: URL(string: viewModel.urlOtherMealImage))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
