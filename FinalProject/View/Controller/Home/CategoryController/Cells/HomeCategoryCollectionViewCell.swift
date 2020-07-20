//
//  HomeCategoryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - Define
private struct Configure {
    static let cornerRadius: CGFloat = 10
}

final class HomeCategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet
    @IBOutlet private weak var thumbnailCategoryImageView: UIImageView!
    @IBOutlet private weak var nameCategoryView: UIView!
    @IBOutlet private weak var nameCategoryLabel: UILabel!
    @IBOutlet private weak var cellCategoryView: UIView!

    // MARK: - Properties
    var viewModel: HomeCellCategoryViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellCategoryView.layer.cornerRadius = Configure.cornerRadius
        nameCategoryLabel.layer.cornerRadius = Configure.cornerRadius
    }

    // MARK: - Private Function
    private func updateView() {
        nameCategoryLabel.text = viewModel?.nameCategory
        guard let viewModel = viewModel else { return }
        thumbnailCategoryImageView.sd_setImage(with: URL(string: viewModel.urlThumbnail))
    }
}
