//
//  DetailCategoryTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

protocol DetailTableViewDelegate: class {
    func addFavorites(cell: DetailCategoryTableViewCell)
    func deleteFavorites(cell: DetailCategoryTableViewCell)
}

final class DetailCategoryTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var thumbnailMealImageView: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var nameMealLabel: UILabel!
    weak var delegate: DetailTableViewDelegate?

    var viewModel: DetailCategoryCellViewModel? {
        didSet {
            updateView()
        }
    }
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContent.layer.cornerRadius = 10
        viewContent.clipsToBounds = true
        nameMealLabel.layer.cornerRadius = 10
        nameMealLabel.clipsToBounds = true
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        nameMealLabel.text = viewModel.nameMeal
        thumbnailMealImageView.sd_setImage(with: URL(string: viewModel.urlThumnailMeal))
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
        //guard let delegate = delegate else { return }
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
        guard let viewModel = viewModel else { return }
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
