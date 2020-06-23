//
//  DetailCategoryTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class DetailCategoryTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var thumbnailMealImageView: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var nameMealLabel: UILabel!
    
    var viewModel: DetailCategoryCellViewModel? {
        didSet {
            updateView()
        }
    }
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContent.layer.cornerRadius = 10
        viewContent.clipsToBounds = true
        nameMealLabel.layer.cornerRadius = 10
        nameMealLabel.clipsToBounds = true
    }

    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        nameMealLabel.text = viewModel.nameMeal
        thumbnailMealImageView.sd_setImage(with: URL(string: viewModel.urlThumnailMeal))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
