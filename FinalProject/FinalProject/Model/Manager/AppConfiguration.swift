//
//  AppConfiguration.swift
//  Sukedachi
//
//  Created by Quang Phu C M on 3/8/19.
//  Copyright © 2019 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

/// It will help you get some values more secrectly by environments config.
final class AppConfiguration {
    
    /// Get the value according to the given key in your bundle
    ///
    /// - Parameter key: The keys that you defined in .xcconfig file
    /// - Returns: The accordingly value
    static func infoForKey(_ key: String) -> String? {
        guard let configs = Bundle.main.infoDictionary?["App Configurations"] as? [String: String],
            let value = configs[key] else { return nil }
        return value.replacingOccurrences(of: "\\", with: "")
    }
    
    /// Get the value according to the given key in your bundle
    ///
    /// - Parameter key: The keys that you defined `AppConfigurationKeys`
    /// - Returns: The accordingly value
    static func infoForKey(_ key: AppConfigurationKeys) -> String? {
        guard let configs = Bundle.main.infoDictionary?["App Configurations"] as? [String: String],
            let value = configs[key.rawValue] else { return nil }
        return value.replacingOccurrences(of: "\\", with: "")
    }
}

enum AppConfigurationKeys: String {
    // Application
    case displayName = "DISPLAY_NAME"
    
    // API
    case baseURL = "BASE_URL"
    case laravelBaseURL = "LARAVEL_BASE_URL"

    // Google
    case googleAPISecretKey = "GOOGLE_API_SECRET_KEY"
    
    // Firebase
    case googleServiceInfo = "GOOGLE_SERVICE_INFO_FILE"

    // JSON web token
    case jsonWebTokenSecretKey = "JSON_WEB_TOKEN_SCRET_KEY"
    
    // AES
    case aesSecretKey = "AES_SECRET_KEY"
    case aesIvKey = "AES_IV_KEY"
    
    // Adjust lib
    case adjustAppToken = "ADJUST_APP_TOKEN"
    
    // Repro lib
    case reproToken = "REPRO_TOKEN"
    
    // Upgrade URL
    case upgradePro = "UPGRADE_PRO"
    case upgradeBizEnt = "UPGRADE_BIZ_ENT"
    
    static func description() {
        print(AppConfiguration.infoForKey(.displayName).content)
        print(AppConfiguration.infoForKey(.baseURL).content)
        print(AppConfiguration.infoForKey(.googleAPISecretKey).content)
        print(AppConfiguration.infoForKey(.googleServiceInfo).content)
        print(AppConfiguration.infoForKey(.jsonWebTokenSecretKey).content)
        print(AppConfiguration.infoForKey(.aesSecretKey).content)
        print(AppConfiguration.infoForKey(.aesIvKey).content)
        print(AppConfiguration.infoForKey(.adjustAppToken).content)
        print(AppConfiguration.infoForKey(.reproToken).content)
        print(AppConfiguration.infoForKey(.upgradePro).content)
    }
}
