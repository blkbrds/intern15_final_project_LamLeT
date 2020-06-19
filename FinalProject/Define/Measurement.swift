//
//  Measurement.swift
//  FinalProject
//
//  Created by Thinh Nguyen X. on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

typealias Measurement = App.Measurement

extension App {
    
    struct Measurement {
        static var tabBarHeight: CGFloat {
            if iPhoneX || iPhoneXR {
                return 83
            } else {
                return 49
            }
        }
        
        static var homeButtonHeight: CGFloat {
            if iPhoneX || iPhoneXR {
                return 34
            } else {
                return 0
            }
        }
        
        static var statusBarHeight: CGFloat {
            if iPhoneX || iPhoneXR {
                return 44
            } else {
                return 20
            }
        }
        
        static let navigationBarHeight: CGFloat = 50
        
        static let iconTabbarSize = CGSize(width: 22, height: 22)
    }
}
