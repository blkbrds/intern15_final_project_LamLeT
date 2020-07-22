//
//  VideoTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import WebKit

// MARK: - Define
private struct Configure {
    static let urlVideo = "https://www.youtube.com/embed/"
}

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

    // MARK: - Private Functions
    private func updateView() {
        if let viewModel = viewModel, let url = viewModel.meal.urlVideoMeal, !url.isEmpty, let youtubeURL = URL(string: "\(Configure.urlVideo)\(viewModel.getLinkVideo())") {
            webView.load(URLRequest(url: youtubeURL))
        } else if let viewModel = viewModel {
            videoAlertLabel.isHidden = false
            videoAlertLabel.text = viewModel.getLinkVideo()
        }
    }
}
