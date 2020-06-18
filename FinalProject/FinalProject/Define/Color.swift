//
//  Color.swift
//  FinalProject
//
//  Created by Thinh Nguyen X. on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//


/**
 This file defines all colors which are used in this application.
 Please navigate by the control as prefix.
 */

import UIKit

extension App {
    struct Color {
        struct Text {
            static let normal = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            static let disable = #colorLiteral(red: 0.7568627451, green: 0.7568627451, blue: 0.7568627451, alpha: 0.3)
            static let textFiledDisable = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
            static let placeholder = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
            static let textViewBackground = #colorLiteral(red: 0.06465802342, green: 0.06466066092, blue: 0.06465925276, alpha: 1)
        }

        struct Role {
            static let pro = #colorLiteral(red: 0.5764705882, green: 0.368627451, blue: 0.2274509804, alpha: 1)
            static let business = #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)
            static let enterprise = #colorLiteral(red: 0.6941176471, green: 0.5764705882, blue: 0, alpha: 1)
        }

        static let statusBar = UIColor(red: 26, green: 26, blue: 26)
        static let navigationBar = UIColor.black
        static let tableHeaderView = UIColor.gray
        static let tableFooterView = UIColor.red
        static let tableCellTextLabel = UIColor.yellow

        static let tabbarBackground = UIColor(red: 40, green: 40, blue: 40)
        static let mainYellow = UIColor(red: 250, green: 190, blue: 0)
        static let mainBlackBackground = UIColor(red: 40, green: 40, blue: 40)
        static let mainBlackBackground095 = UIColor.black.withAlphaComponent(0.95)
        static let textYellow = UIColor(red: 255, green: 220, blue: 51)
        static let textYellowDisable = UIColor(red: 255, green: 220, blue: 51, transparency: 0.2)

        static func button(state: UIControl.State) -> UIColor {
            switch state {
            case UIControl.State.normal: return .blue
            default: return .gray
            }
        }
        static let gray1A = UIColor(hexString: "1A1A1A")
        static let gray60 = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        static let gray62 = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        static let gray71 = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1)
        static let gray90 = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
        static let gray151 = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        static let gray126 = #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1)
        static let gray216 = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    }
}
