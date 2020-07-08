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
        guard let viewModel = viewModel else {
            return
        }
        var idVideo: String = ""
        if viewModel.meal.urlVideoMeal == "" {
            videoAlertLabel.isHidden = false
            videoAlertLabel.text = "No Has Video Tutorial" 
        } else {
            let arrayURLVideo = Array(viewModel.meal.urlVideoMeal)
            for i in 0...arrayURLVideo.count - 1 {
                if arrayURLVideo[i] == "=" {
                    let idVideoArray = arrayURLVideo[i + 1 ..< arrayURLVideo.endIndex]
                    idVideo = String(idVideoArray)
                }
            }
            guard let youtubeURL = URL(string: "\(DetailMealTableViewCellViewModel.Configure.urlVideo)\(idVideo)") else {
                return
            }
            webView.load(URLRequest(url: youtubeURL))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
