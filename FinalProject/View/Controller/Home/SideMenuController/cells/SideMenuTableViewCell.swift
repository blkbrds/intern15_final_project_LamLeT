//
//  SideMenuTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 7/2/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var sideMenuImageView: UIImageView!
    @IBOutlet weak var nameSideMenuLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        sideMenuImageView.layer.borderWidth = 1
        sideMenuImageView.layer.masksToBounds = false
        sideMenuImageView.layer.cornerRadius = sideMenuImageView.frame.height / 2
        sideMenuImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
