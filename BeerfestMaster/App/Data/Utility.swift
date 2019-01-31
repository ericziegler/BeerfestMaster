//
//  Utility.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/9/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

let AppVersionCacheKey = "AppVersionCacheKey"

func versionUpToDate() -> Bool {
    let versionNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    var result = false
    if let cachedVersionNumber = UserDefaults.standard.object(forKey: AppVersionCacheKey) as? String {
        if cachedVersionNumber != versionNumber {
            result = false
        } else {
            result = true
        }
    }
    UserDefaults.standard.set(versionNumber, forKey: AppVersionCacheKey)
    UserDefaults.standard.synchronize()
    return result
}
