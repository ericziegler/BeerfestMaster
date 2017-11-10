//
//  BaseNavigationController.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/10/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return CurrentFest.preferredStatusBarStyle
  }
  
}
