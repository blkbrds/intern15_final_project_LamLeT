//
//  SideMenuTableViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 7/2/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

protocol SideMenuTableViewDelegate: class {
    func pushToLocationMenu(vc: UIViewController)
}

class SideMenuTableViewController: UITableViewController {

    weak var delegate: SideMenuTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nibWithCellClass: LogoMenuTableViewCell.self)
        tableView.register(nibWithCellClass: SideMenuTableViewCell.self)
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ConfigureForTable.numberOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return ItemArray.nameSideMenu.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return ConfigureForTable.heightSection1
        } else {
            return ConfigureForTable.heightSection2
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withClass: LogoMenuTableViewCell.self, for: indexPath)
            cell.logoMenuImageView.image = UIImage(named: ConfigureForTable.logoImage)
            cell.nameLogoLabel.text = ConfigureForTable.logoName
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withClass: SideMenuTableViewCell.self, for: indexPath)
            cell.nameSideMenuLabel.text = "   \(ItemArray.nameSideMenu[indexPath.row])"
            cell.sideMenuImageView.image = UIImage(named: ItemArray.imageSideMenu[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            let vc: [UIViewController] = [HomeCategoryViewController(), CountryViewController()]
            if let delegate = delegate {
                delegate.pushToLocationMenu(vc: vc[indexPath.row])
            }
        }
    }
}

// MARK: -  Define
struct ConfigureForTable {
    static let logoImage: String = "beginner2"
    static let logoName: String = "Cook For Beginner"
    static let heightSection1: CGFloat = 200
    static let heightSection2: CGFloat = 80
    static let numberOfSection: Int = 2
}
