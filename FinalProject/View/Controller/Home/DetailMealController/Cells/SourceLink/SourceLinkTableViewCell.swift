//
//  SourceLinkTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SafariServices

// MARK: - Protocol
protocol SourceLinkTableViewCellDelegate: class {
    func openWeb(url: URL)
}

final class SourceLinkTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var openWebButton: UIButton!

    // MARK: - Properties
    weak var delegate: SourceLinkTableViewCellDelegate?
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private Functions
    private func updateView() {
        if let viewModel = viewModel, let sourceLink = viewModel.meal.sourceLink, sourceLink.isEmpty {
            openWebButton.setTitle("No Has Link", for: .normal)
        }
    }

    // MARK: - IBAction
    @IBAction private func openWebTouchUpInside(_ sender: Any) {
        if let delegate = delegate, let viewModel = viewModel, let sourceLink = viewModel.meal.sourceLink, let url = URL(string: sourceLink) {
            delegate.openWeb(url: url)
        }
    }
}
