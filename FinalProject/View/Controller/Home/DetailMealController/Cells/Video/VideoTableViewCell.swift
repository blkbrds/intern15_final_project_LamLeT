//
//  VideoTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import WebKit

final class VideoTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var videoAlertLabel: UILabel!

    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        videoAlertLabel.isHidden = true
    }

    private func updateView() {
        showVideo()
    }

    private func showVideo() {
        guard let viewModel = viewModel, let urlVideoMeal = viewModel.meal.urlVideoMeal else {
            return
        }
        if urlVideoMeal.isEmpty {
            videoAlertLabel.isHidden = false
            videoAlertLabel.text = viewModel.getLinkVideo()
        } else {
            guard let youtubeURL = URL(string: "\(DetailMealTableViewCellViewModel.Configure.urlVideo)\(viewModel.getLinkVideo())") else {
                return
            }
            webView.load(URLRequest(url: youtubeURL))
        }
    }
}
