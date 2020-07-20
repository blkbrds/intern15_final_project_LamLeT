//
//  OrtherFoodTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/1/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

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
        otherFoodView.layer.cornerRadius = OtherFoodCellViewModel.Configure.cornerRadius
        nameOtherFoodLabel.layer.cornerRadius = OtherFoodCellViewModel.Configure.cornerRadius
    }

    private func updateView() {
        nameOtherFoodLabel.text = viewModel.otherMealName
        otherFoodImageView.sd_setImage(with: URL(string: viewModel.urlOtherMealImage))
    }
}
