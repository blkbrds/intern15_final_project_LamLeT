//
//  URLRequestExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/5/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(Foundation)
import Foundation

// MARK: - Initializers
public extension URLRequest {

    /// SwifterSwift: Create URLRequest from URL string.
    ///
    /// - Parameter urlString: URL string to initialize URL request from
    public init?(apiListCategory: String) {
        guard let url = URL(string: apiListCategory) else { return nil }
        self.init(url: url)
    }

}
#endif
