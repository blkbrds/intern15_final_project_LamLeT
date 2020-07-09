//
//  InfoTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class InfoTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var nameMeal: UILabel!
    @IBOutlet private weak var nameArea: UILabel!
    @IBOutlet private weak var nameCategory: UILabel!
    @IBOutlet private weak var nameTags: UILabel!
    
    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Private Functions
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        nameMeal.text = viewModel.meal.mealName
        nameArea.text = viewModel.meal.area
        nameCategory.text = viewModel.meal.category
        nameTags.text = viewModel.meal.tags
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
