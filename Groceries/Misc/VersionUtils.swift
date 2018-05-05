//
//  VersionUtils.swift
//  Groceries
//
//  Created by Illia Akhaiev on 5/5/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

struct VersionUtils {
    private enum Keys: String {
        case version = "CFBundleShortVersionString"
        case build = "CFBundleVersion"
    }
    
    private static let emptyVersion = "v0"
    private static let format = "v%@ (%@)"
    
    static func loadVersion() -> String {
        guard
            let dict = Bundle.main.infoDictionary,
            let version = dict[Keys.version.rawValue] as? String,
            let build = dict[Keys.build.rawValue] as? String
        else {
            return emptyVersion
        }
        
        return String(format: format, version, build)
    }
}
