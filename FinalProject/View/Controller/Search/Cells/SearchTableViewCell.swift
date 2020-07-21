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
    @IBOutlet private weak var favoritesButton: UIButton!

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

        viewModel.checkFavorites(completion: { (isExist, msg) in
            if isExist {
                let image = UIImage(systemName: "heart.fill")
                self.favoritesButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(systemName: "heart")
                self.favoritesButton.setImage(image, for: .normal)
            }
        })
    }

    @IBAction func favoritesButtonTouchUpInside(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        viewModel.checkFavorites(completion: { (isExist, msg) in
            if isExist {
                self.deleteFavorites()
            } else {
                self.addFavorites()
            }
        })
    }

    func addFavorites() {
        guard let viewModel = viewModel else { return }
        viewModel.addFavorites(completion: { (done, msg) in
            if done {
                let image = UIImage(systemName: "heart.fill")
                self.favoritesButton.setImage(image, for: .normal)
            } else {
                print("Add To Failed")
            }
        })
    }

    func deleteFavorites() {
        guard let viewModel = viewModel else { return }
        viewModel.deleteFavorites(completion: { (done, msg) in
            if done {
                let image = UIImage(systemName: "heart")
                self.favoritesButton.setImage(image, for: .normal)
            } else {
                print("Delete To Failed")
            }
        })
    }
}

