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
    var viewModel: InforCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: Private Functions
    private func updateView() {
        guard let viewModel = viewModel else { return }
        ingredientLabel.text = viewModel.name
        measureLabel.text = viewModel.value
    }
}
