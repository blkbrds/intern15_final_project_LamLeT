//
//  SearchTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/9/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var nameMealLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!

    var viewModel: SearchTableCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        nameMealLabel.text = viewModel.mealName
        thumbnailImageView.sd_setImage(with: URL(string: viewModel.urlThumbnail))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
