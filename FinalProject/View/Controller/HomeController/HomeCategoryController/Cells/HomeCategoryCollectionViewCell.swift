//
//  HomeCategoryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SDWebImage

final class HomeCategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    @IBOutlet private weak var thumbnailCategoryImageView: UIImageView!
    @IBOutlet private weak var nameCategoryView: UIView!
    @IBOutlet private weak var nameCategoryLabel: UILabel!
    @IBOutlet private weak var cellCategoryView: UIView!

    var viewModel: HomeCellCategoryViewModel? {
        didSet {
            updateView()
        }		
    }

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellCategoryView.layer.cornerRadius = 10
        cellCategoryView.clipsToBounds = true
        nameCategoryLabel.layer.cornerRadius = 10
        nameCategoryLabel.clipsToBounds = true
    }

    // MARK: - Private Function
    private func updateView() {
        nameCategoryLabel.text = viewModel?.nameCategory
        guard let viewModel = viewModel else {
            return
        }
        thumbnailCategoryImageView.sd_setImage(with: URL(string: viewModel.urlThumbnail))
    }

}
