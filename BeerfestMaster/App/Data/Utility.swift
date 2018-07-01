//
//  Utility.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/9/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

let CurrentVersionCacheKey = "CurrentVersionCacheKey"

var versionNumber: String {
  get {
    var result = ""    
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
      result = version
    }
    return result
  }
}

func saveAppVersionNumber() {
  UserDefaults.standard.set(versionNumber, forKey: CurrentVersionCacheKey)
  UserDefaults.standard.synchronize()
}

func loadAppVersionNumber() -> String? {
  return UserDefaults.standard.object(forKey: CurrentVersionCacheKey) as? String
}
