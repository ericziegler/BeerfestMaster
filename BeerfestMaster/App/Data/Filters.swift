//
//  Filters.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/8/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

let ShowConnoisseurCacheKey = "ShowConnoisseurCacheKey"
let ShowEarlyAdmissionCacheKey = "ShowEarlyAdmissionCacheKey"
let ShowQuickPourCacheKey = "ShowQuickPourCacheKey"

class Filters {
  
  // MARK: Properties
  
  var showConnoisseur = true
  var showEarlyAdmission = true
  var showQuickPour = true
  
  // MARK: Init
  
  static let shared = Filters()
  
  init() {
    self.loadFilters()
    self.saveFilters()
  }
  
  // MARK: Save / Load
  
  func loadFilters() {
    let defaults = UserDefaults.standard
    if let _ = defaults.object(forKey: ShowEarlyAdmissionCacheKey) {
      self.showEarlyAdmission = defaults.bool(forKey: ShowEarlyAdmissionCacheKey)
    }
    if let _ = defaults.object(forKey: ShowConnoisseurCacheKey) {
      self.showConnoisseur = defaults.bool(forKey: ShowConnoisseurCacheKey)
    }
    if let _ = defaults.object(forKey: ShowQuickPourCacheKey) {
      self.showQuickPour = defaults.bool(forKey: ShowQuickPourCacheKey)
    }
  }
  
  func saveFilters() {
    let defaults = UserDefaults.standard
    defaults.set(self.showEarlyAdmission, forKey: ShowEarlyAdmissionCacheKey)
    defaults.set(self.showConnoisseur, forKey: ShowConnoisseurCacheKey)
    defaults.set(self.showQuickPour, forKey: ShowQuickPourCacheKey)
    defaults.synchronize()
  }
  
}
