//
//  HomeCategoryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/19/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    @IBOutlet private weak var thumbnailCategoryImageView: UIImageView!
    @IBOutlet private weak var categoryView: UIView!
    @IBOutlet private weak var nameCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
