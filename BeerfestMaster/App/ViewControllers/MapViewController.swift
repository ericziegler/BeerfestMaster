//
//  MapViewController.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/10/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let MapViewId = "MapViewId"

class MapViewController: BaseViewController {

  // MARK: Properties
  
  @IBOutlet var imageView: GTZoomableImageView!
  
  // MARK: Init
  
  class func createController() -> MapViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: MapViewController = storyboard.instantiateViewController(withIdentifier: MapViewId) as! MapViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.imageView.image = CurrentFest.map
    if CurrentFest == .rarebeerfest {
      self.navigationItem.title = "MAP"
    }
  }
  
}
