//
//  VideoTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import WebKit

class VideoTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var webView: WKWebView!

    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        var idVideo: String = ""
        let arrayURLVideo = Array(viewModel.urlVideoMeal)
        print(arrayURLVideo.count)
        for i in 0...arrayURLVideo.count - 1 {
            if arrayURLVideo[i] == "=" {
                let idVideoArray = arrayURLVideo[i + 1 ..< arrayURLVideo.endIndex]
                idVideo = String(idVideoArray)
            }
        }
        print(idVideo)
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(idVideo)") else {
            return
        }
        webView.load(URLRequest(url: youtubeURL))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
