//
//  UIColor+Beerfest.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/8/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

extension UIColor {

  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((hex & 0x00FF00) >> 08) / 255.0
    let b = CGFloat((hex & 0x0000FF) >> 00) / 255.0
    self.init(red:r, green:g, blue:b, alpha:alpha)
  }
  
  convenience init(integerRed red: Int, green: Int, blue: Int, alpha: Int = 255) {
    let r = CGFloat(red) / 255.0
    let g = CGFloat(green) / 255.0
    let b = CGFloat(blue) / 255.0
    let a = CGFloat(alpha) / 255.0
    self.init(red:r, green:g, blue:b, alpha:a)
  }
  
  class var navBar: UIColor {
    return UIColor(hex: 0xf2f2f2, alpha: 1)
  }
  
  class var tabBar: UIColor {
    return UIColor.navBar
  }
  
  class var accent: UIColor {
    return CurrentFest.accentColor
  }
  
  class var lightText: UIColor {
    return UIColor(hex: 0xcccccc, alpha: 1)
  }
  
  class var mediumText: UIColor {
    return UIColor(hex: 0x777777, alpha: 1)
  }
  
  class var darkText: UIColor {
    return UIColor(hex: 0x111111, alpha: 1)
  }
  
  class var mainBackground: UIColor {
    return UIColor(hex: 0xffffff, alpha: 1)
  }
  
  class var connoissur: UIColor {
    return UIColor(hex: 0xeecdcd)
  }
  
  class var earlyAdmission: UIColor {
    return UIColor(hex: 0xfdf2d0)
  }
  
  class var quickPour: UIColor {
    return UIColor(hex: 0xccdaf5)
  }
  
}
