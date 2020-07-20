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
    @IBOutlet private weak var mealLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var tagLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Private Functions
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        mealLabel.text = viewModel.meal.mealName
        areaLabel.text = viewModel.meal.area
        categoryLabel.text = viewModel.meal.category
        tagLabel.text = viewModel.meal.tags
    }
}
