//
//  RareFilters.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 10/20/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

let HasPreviouslySavedRareFiltersCacheKey = "HasPreviouslySavedRareFiltersCacheKey"
let ShowTaproomCacheKey = "ShowTaproomCacheKey"
let ShowAnnexCacheKey = "ShowAnnexCacheKey"
let ShowEventSpaceCacheKey = "ShowEventSpaceCacheKey"

class RareFilters {
  
  // MARK: Properties
  
  var showTaproom = true
  var showAnnex = true
  var showEventSpace = true
  
  // MARK: Init
  
  static let shared = RareFilters()
  
  init() {
    self.loadFilters()
    self.saveFilters()
  }
  
  // MARK: Save / Load
  
  func loadFilters() {
    let defaults = UserDefaults.standard
    if defaults.bool(forKey: HasPreviouslySavedRareFiltersCacheKey) == true {
      self.showTaproom  = defaults.bool(forKey: ShowTaproomCacheKey)
      self.showAnnex = defaults.bool(forKey: ShowAnnexCacheKey)
      self.showEventSpace = defaults.bool(forKey: ShowEventSpaceCacheKey)
    }
  }
  
  func saveFilters() {
    let defaults = UserDefaults.standard
    defaults.set(self.showTaproom, forKey: ShowTaproomCacheKey)
    defaults.set(self.showAnnex, forKey: ShowAnnexCacheKey)
    defaults.set(self.showEventSpace, forKey: ShowEventSpaceCacheKey)
    defaults.set(true, forKey: HasPreviouslySavedRareFiltersCacheKey)
    defaults.synchronize()
  }
  
}
