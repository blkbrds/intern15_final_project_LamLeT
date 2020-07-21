//
//  CountryCollectionViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/16/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

private struct Configure {
    static let cornerRadius: CGFloat = 10
}

class CountryCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var areaNameLabel: UILabel!
    @IBOutlet private weak var flagCountryImageView: UIImageView!
    @IBOutlet private weak var countryView: UIView!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        countryView.cornerRadius = Configure.cornerRadius
        areaNameLabel.cornerRadius = Configure.cornerRadius
    }

    // MARK: - Properties
    var viewModel: CountryCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private Functions
    private func updateView() {
        guard let viewModel = viewModel else { return }
        areaNameLabel.text = viewModel.nameArea
        flagCountryImageView.sd_setImage(with: URL(string: viewModel.urlFlagCountry))
    }
}
