//
//  Font.swift
//  Sukedachi
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

/**
 This file defines all fonts which are used in this application.
 Please navigate by the control as prefix.
 Please create base class for automatic font loading.
 */

import UIKit

let fontScale = loadFontScale()

func loadFontScale() -> CGFloat {
    switch UIDevice.current.userInterfaceIdiom {
    case .pad: return 1.3
    default: return ratio
    }
}

protocol Fontable {
    static var name: String { get }
}

// MARK: - Fontable
extension Fontable {
    static func font(type: String, _ size: CGFloat) -> UIFont {
        let fontName = name + type
        if let font = UIFont(name: fontName, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}

protocol JapaneseFontTypeable {
    static func w3(size: CGFloat, scale: CGFloat) -> UIFont
    static func w6(size: CGFloat, scale: CGFloat) -> UIFont
}

protocol RobotoFontTypeable {
    static func thin(size: CGFloat, scale: CGFloat) -> UIFont
    static func light(size: CGFloat, scale: CGFloat) -> UIFont
    static func regular(size: CGFloat, scale: CGFloat) -> UIFont
}

// MARK: - JapaneseFontTypeable
extension JapaneseFontTypeable where Self: Fontable {
    static func w3(size: CGFloat, scale: CGFloat = fontScale) -> UIFont {
        return font(type: "-W3", size * scale)
    }

    static func w6(size: CGFloat, scale: CGFloat = fontScale) -> UIFont {
        return font(type: "-W6", size * scale)
    }
}

// MARK: - RobotoFontTypeable
extension RobotoFontTypeable where Self: Fontable {
    static func thin(size: CGFloat, scale: CGFloat = fontScale) -> UIFont {
        return font(type: "-Thin", size * scale)
    }

    static func light(size: CGFloat, scale: CGFloat = fontScale) -> UIFont {
        return font(type: "-Light", size * scale)
    }

    static func regular(size: CGFloat, scale: CGFloat = fontScale) -> UIFont {
        return font(type: "-Regular", size * scale)
    }
}

extension App {
    struct Font {
        static var navigationBar: UIFont {
            return .boldSystemFont(ofSize: 14)
        }

        static var tableHeaderViewTextLabel: UIFont {
            return .boldSystemFont(ofSize: 14)
        }

        static var tableFooterViewTextLabel: UIFont {
            return .boldSystemFont(ofSize: 14)
        }

        static var tableCellTextLabel: UIFont {
            return .systemFont(ofSize: 14)
        }

        static var buttonTextLabel: UIFont {
            return .boldSystemFont(ofSize: 14)
        }
    }
}

extension App.Font {
    struct Hiragino: Fontable, JapaneseFontTypeable {
        static var name: String { return "HiraginoSans" }
    }

    struct HiraginoKaku: Fontable, JapaneseFontTypeable {
        static var name: String { return "HiraginoKakuGothicProN" }
    }

    struct Roboto: Fontable, RobotoFontTypeable {
        static var name: String { return "Roboto" }
    }
}
