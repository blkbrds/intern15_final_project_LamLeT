//
//  ImageTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SDWebImage

final class ImageTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var thumnailMealImageView: UIImageView!
    @IBOutlet private weak var thumbmailView: UIView!
    
    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumnailMealImageView.layer.cornerRadius = 10
        thumnailMealImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        thumnailMealImageView.sd_setImage(with: URL(string: viewModel.meal.urlMealThumbnail))
    }
}
