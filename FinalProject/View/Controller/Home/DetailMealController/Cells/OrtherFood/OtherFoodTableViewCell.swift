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

    // MARK: - Properties
    var viewModel: OtherFoodCellViewModel = OtherFoodCellViewModel() {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        otherFoodView.cornerRadius = Configure.cornerRadius
        nameOtherFoodLabel.cornerRadius = Configure.cornerRadius
    }

    // MARK: - Private Functions
    private func updateView() {
        nameOtherFoodLabel.text = viewModel.otherMealName
        otherFoodImageView.sd_setImage(with: URL(string: viewModel.urlOtherMealImage))
    }
}
