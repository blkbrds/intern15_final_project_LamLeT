//
//  OrtherFoodTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/1/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class OtherFoodTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var otherFoodView: UIView!
    @IBOutlet private weak var otherFoodImageView: UIImageView!
    @IBOutlet private weak var nameOtherFoodLabel: UILabel!
    @IBOutlet private weak var nameOtherFoodView: UIView!
    @IBOutlet private weak var favoritesButton: UIButton!

    // MARK: - Properties
    var viewModel: OtherFoodCellViewModel = OtherFoodCellViewModel() {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        otherFoodView.layer.cornerRadius = 10
        otherFoodView.clipsToBounds = true
        nameOtherFoodLabel.layer.cornerRadius = 10
        nameOtherFoodLabel.clipsToBounds = true
    }

    private func updateView() {
        nameOtherFoodLabel.text = viewModel.otherMealName
        otherFoodImageView.sd_setImage(with: URL(string: viewModel.urlOtherMealImage))
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

    // MARK: - IBAction
    @IBAction func favoritesButtonTouchUpInside(_ sender: Any) {
        viewModel.checkFavorites(completion: { (isExist, msg) in
            if isExist {
                self.deleteFavorites()
            } else {
                self.addFavorites()
            }
        })
    }

    func addFavorites() {
        viewModel.addFavorites(completion: { (done, msg) in
            if done {
                let image = UIImage(systemName: "heart.fill")
                self.favoritesButton.setImage(image, for: .normal)
            } else {
                print("Can't Add")
            }
        })
    }

    func deleteFavorites() {
        viewModel.deleteFavorites(completion: { (done, msg) in
            if done {
                let image = UIImage(systemName: "heart")
                self.favoritesButton.setImage(image, for: .normal)
            } else {
                print("Can't Delete")
            }
        })
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
