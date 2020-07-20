//
//  InstructionsTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class InstructionsTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var instructionLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        instructionLabel.text = viewModel.meal.instructions
    }
}
