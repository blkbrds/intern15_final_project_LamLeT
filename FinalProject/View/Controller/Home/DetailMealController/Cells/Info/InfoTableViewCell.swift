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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!


    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        nameLabel.text = viewModel?.name
//        valueLabel.text = viewModel?.value
    }

    // MARK: - Private Functions
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        nameLabel.text = viewModel.name
        valueLabel.text = viewModel.value
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
