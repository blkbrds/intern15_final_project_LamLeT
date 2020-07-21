//
//  LogoMenuTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/2/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

class LogoMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIView!
    @IBOutlet weak var logoMenuImageView: UIImageView!
    @IBOutlet weak var nameLogoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailView.cornerRadius = thumbnailView.frame.height / 2
        thumbnailView.clipsToBounds = true
        logoMenuImageView.cornerRadius = logoMenuImageView.frame.height / 2
        logoMenuImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
