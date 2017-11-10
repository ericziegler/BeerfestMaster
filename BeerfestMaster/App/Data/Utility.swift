//
//  Utility.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/9/17.
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
      return "Philly"
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
      return UIColor(hex: 0x3a7d49)
    case .pittsburgh:
      return UIColor(hex: 0xffcc00)
    }
  }
  
}

let CurrentFest = FestCity.pittsburgh
