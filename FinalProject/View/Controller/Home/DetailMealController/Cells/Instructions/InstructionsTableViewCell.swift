//
//  InstructionsTableViewCell.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class InstructionsTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var instructionLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: DetailMealTableViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateView() {
        guard let viewModel = viewModel else {
            return
        }
        instructionLabel.text = viewModel.meal.instructions
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


//    private func updateView() {
//        guard let viewModel = viewModel else { return }
//        if viewModel.meal.sourceLink == "" {
//            let text = "No Has Source"
//            let attributedString = NSMutableAttributedString(string: text)
//            attributedString.addAttribute(.link, value: viewModel.meal.sourceLink, range: NSRange(location: 0, length: text.count))
//            sourceLinkTextView.attributedText = attributedString
//        } else {
//            let text = viewModel.meal.sourceLink
//            let attributedString = NSMutableAttributedString(string: text)
//            attributedString.addAttribute(.link, value: viewModel.meal.sourceLink, range: NSRange(location: 0, length: text.count))
//            sourceLinkTextView.attributedText = attributedString
//        }
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}
//
//extension SourceLinkTableViewCell: UITextViewDelegate {
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        UIApplication.shared.open(URL)
//        return false
//    }
//}
