//
//  CurrentFest.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/10/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

enum FestCity: String {
  
  case cleveland
  case cincinnati
  case columbus
  case philadelphia
  case pittsburgh
  case rarebeerfest
  
  var displayString: String {
    switch self {
    case .cleveland:
      return "Cleveland"
    case .cincinnati:
      return "Cincy"
    case .columbus:
      return "Columbus"
    case .philadelphia:
      return "Big Philly"
    case .pittsburgh:
      return "Pittsburgh"
    case .rarebeerfest:
      return "RARE BEER FEST"
    }
  }
  
  var navigationTitle: String {
    if self == .rarebeerfest {
      return "RARE BEER FEST"
    } else {
      return "Beerfest"
    }
  }
  
  var accentColor: UIColor {
    switch self {
    case .cleveland:
      return UIColor(hex: 0xe47e49)
    case .cincinnati:
      return UIColor(hex: 0xd63c39)
    case .columbus:
      return UIColor(hex: 0xd63c39)
    case .philadelphia:
      return UIColor(hex: 0x4ba435)
    case .pittsburgh:
      return UIColor(hex: 0xffcc00)
    case .rarebeerfest:
      return UIColor(hex: 0x367c91)
    }
  }
  
  var lightAccentColor: UIColor {
    switch self {
    case .cleveland:
      return UIColor(hex: 0xe47e49)
    case .cincinnati:
      return UIColor(hex: 0xff474a)
    case .columbus:
      return UIColor(hex: 0xff474a)
    case .philadelphia:
      return UIColor(hex: 0x64d946)
    case .pittsburgh:
      return UIColor(hex: 0xffcc00)
    case .rarebeerfest:
      return UIColor(hex: 0x367c91)
    }
  }
  
  var navBarColor: UIColor {
    if CurrentFest == .rarebeerfest {
      return UIColor(hex: 0xfbedd8)
    }
    return UIColor(hex: 0x242424)
  }
  
  var navBarTitleColor: UIColor {
    if CurrentFest == .rarebeerfest {
      return UIColor(hex: 0xd24a3a)
    }
    return UIColor(hex: 0xffffff)
  }
  
  var tabBarNormalColor: UIColor {
    if CurrentFest == .rarebeerfest {
      return UIColor(hex: 0xd24a3a, alpha: 0.75)
    }
    return UIColor(hex: 0xffffff)
  }
  
  var preferredStatusBarStyle: UIStatusBarStyle {
    if CurrentFest == .rarebeerfest {
      return .default
    }
    return .lightContent
  }
  
  var map: UIImage? {
    switch self {
    case .cleveland:
      return UIImage(named: "Map-Cleveland")
    case .cincinnati:
      return UIImage(named: "Map-Cincinnati")
    case .columbus:
      return UIImage(named: "Map-Columbus")
    case .philadelphia:
      return UIImage(named: "Map-Philadelphia")
    case .pittsburgh:
      return UIImage(named: "Map-Pittsburgh")
    case .rarebeerfest:
      // TODO: EZ - Change from cincinnati to rare beer fest
      return UIImage(named: "Map-Cincinnati")
    }
  }
  
  var listFile: String {
    switch self {
    case .cleveland:
      return "cleveland"
    case .cincinnati:
      return "cincinnati"
    case .columbus:
      return "columbus"
    case .philadelphia:
      return "philadelphia"
    case .pittsburgh:
      return "pittsburgh"
    case .rarebeerfest:
      return "rarebeerfest"
    }
  }
  
  var mapLocation: String {
    switch self {
    case .cleveland:
      return "cleveland-map"
    case .cincinnati:
      return "cincinnati-map"
    case .columbus:
      return "columbus-map"
    case .philadelphia:
      return "philadelphia-map"
    case .pittsburgh:
      return "pittsburgh-map"
    case .rarebeerfest:
      // TODO: EZ - Change from cincinnati to rare beer fest
      return "cincinnati-map"
    }
  }
  
  var hasBoothNumbers: Bool {
    switch self {
    case .pittsburgh, .rarebeerfest:
      return true
    default:
      return false
    }
  }
  
}

let CurrentFest = FestCity.rarebeerfest
