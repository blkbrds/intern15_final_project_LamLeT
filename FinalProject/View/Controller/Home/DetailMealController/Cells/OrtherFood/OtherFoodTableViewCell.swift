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
        otherFoodView.layer.cornerRadius = 10
        otherFoodView.clipsToBounds = true
        nameOtherFoodLabel.layer.cornerRadius = 10
        nameOtherFoodLabel.clipsToBounds = true
    }

    private func updateView() {
        nameOtherFoodLabel.text = viewModel.otherMealName
        otherFoodImageView.sd_setImage(with: URL(string: viewModel.urlOtherMealImage))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
