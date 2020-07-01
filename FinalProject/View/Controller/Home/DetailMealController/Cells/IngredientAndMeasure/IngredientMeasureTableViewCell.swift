//
//  IngredientTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class IngredientMeasureTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var ingredientLabel: UILabel!
    @IBOutlet private weak var measureLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel = DetailMealTableViewCellViewModel() {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateView() {
        ingredientLabel.text = viewModel.ingredient
        measureLabel.text = viewModel.measure
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
