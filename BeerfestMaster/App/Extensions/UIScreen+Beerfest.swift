//
//  UIScreen+Beerfest.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 6/28/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

let iPhoneSESize = CGSize(width: 320, height: 568)
let iPhone678Size = CGSize(width: 375, height: 667)
let iPhone678PlusSize = CGSize(width: 414, height: 736)
let iPhoneXSize = CGSize(width: 375, height: 812)
let iPadSize = CGSize(width: 320, height: 480)
let iPadProSize = CGSize(width: 375.0, height: 667.0)

extension UIScreen {
    
    static var uiKitScreenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
}
