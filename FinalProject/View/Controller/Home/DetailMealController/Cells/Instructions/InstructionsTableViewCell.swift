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
    @IBOutlet weak var instructionLabel: UILabel!
    
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
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        instructionLabel.text = viewModel.meal.instructions
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
