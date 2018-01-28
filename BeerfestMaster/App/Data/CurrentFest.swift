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
    }
  }
  
  var navBarColor: UIColor {
    return UIColor(hex: 0x242424)
  }
  
  var navBarTitleColor: UIColor {
    return UIColor(hex: 0xffffff)
  }
  
  var tabBarNormalColor: UIColor {
    return UIColor(hex: 0xffffff)
  }
  
  var preferredStatusBarStyle: UIStatusBarStyle {
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
    }
  }
  
}

let CurrentFest = FestCity.cleveland
