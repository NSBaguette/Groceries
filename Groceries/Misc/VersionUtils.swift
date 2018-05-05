//
//  VersionUtils.swift
//  Groceries
//
//  Created by Illia Akhaiev on 5/5/18.
//  Copyright © 2018 Illia Akhaiev. All rights reserved.
//

import Foundation

struct VersionUtils {
    static func loadVersion() -> String {
        guard
            let dict = Bundle.main.infoDictionary,
            let version = dict["CFBundleShortVersionString"] as? String,
            let build = dict["CFBundleVersion"] as? String
        else {
            return "v0.0"
        }
        
        return "v\(version).\(build)"
    }
}
