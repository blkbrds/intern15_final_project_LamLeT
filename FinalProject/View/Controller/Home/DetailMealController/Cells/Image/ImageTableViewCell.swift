//
//  ImageTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SDWebImage

struct Configure {
    static let cornerRadius: CGFloat = 10
}

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
        thumnailMealImageView.layer.cornerRadius = Configure.cornerRadius
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        thumnailMealImageView.sd_setImage(with: URL(string: viewModel.meal.urlMealThumbnail))
    }
}
