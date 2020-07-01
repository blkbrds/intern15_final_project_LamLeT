//
//  OrtherFoodTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/1/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class OrtherFoodTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var ortherFoodView: UIView!
    @IBOutlet private weak var ortherFoodImageView: UIImageView!
    @IBOutlet private weak var nameOrtherFoodLabel: UILabel!
    @IBOutlet weak var nameOrtherFoodView: UIView!
    
    // MARK: - Properties
    var viewModel: OrtherFoodCellViewModel = OrtherFoodCellViewModel() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateView() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        nameOrtherFoodLabel.text = viewModel.ortherMealName
        ortherFoodImageView.sd_setImage(with: URL(string: viewModel.urlOrtherMealImage))
    }
}
