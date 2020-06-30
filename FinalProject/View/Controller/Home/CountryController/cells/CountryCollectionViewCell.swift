//
//  CountryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/23/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class CountryCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    @IBOutlet private weak var areaNameLabel: UILabel!
    @IBOutlet private weak var flagCountryImageView: UIImageView!
    
    var viewModel: CountryCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Private Functions
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        areaNameLabel.text = viewModel.nameArea
        flagCountryImageView.sd_setImage(with: URL(string: viewModel.urlFlagCountry))
    }
}
