//
//  SourceLinkTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class SourceLinkTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var sourceLinkTextView: UITextView!

    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }

    private func updateView() {
        guard let viewModel = viewModel, let text = viewModel.meal.sourceLink else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: viewModel.meal.sourceLink, range: NSRange(location: 0, length: text.count))
        sourceLinkTextView.attributedText = attributedString
    }
}

// MARK: - UITextViewDelegate
extension SourceLinkTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
