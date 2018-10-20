//
//  RareFiltersViewController.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 10/20/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let RareFiltersViewId = "RareFiltersViewId"

class RareFiltersViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet var taproomSwitch: UISwitch!
  @IBOutlet var annexSwitch: UISwitch!
  @IBOutlet var eventSpaceSwitch: UISwitch!
  
  // MARK: Init
  
  class func createController() -> RareFiltersViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: RareFiltersViewController = storyboard.instantiateViewController(withIdentifier: RareFiltersViewId) as! RareFiltersViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavBar()
    self.setupSwitches()
    self.updateFilters()
  }
  
  private func setupNavBar() {
    self.navigationItem.title = "Filters"
    if let closeImage = UIImage(named: "Close")?.maskedImageWithColor(UIColor.lightAccent) {
      let closeButton = UIButton(type: .custom)
      closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
      closeButton.setImage(closeImage, for: .normal)
      closeButton.frame = CGRect(x: 0, y: 0, width: closeImage.size.width, height: closeImage.size.height)
      let closeItem = UIBarButtonItem(customView: closeButton)
      
      self.navigationItem.rightBarButtonItems = [closeItem]
    }
  }
  
  private func setupSwitches() {
    self.taproomSwitch.tintColor = UIColor.taproomLight
    self.taproomSwitch.onTintColor = UIColor.taproom
    self.annexSwitch.tintColor = UIColor.annexLight
    self.annexSwitch.onTintColor = UIColor.annex
    self.eventSpaceSwitch.tintColor = UIColor.eventSpaceLight
    self.eventSpaceSwitch.onTintColor = UIColor.eventSpace
  }
  
  func updateFilters() {
    let filters = RareFilters.shared
    self.taproomSwitch.isOn = filters.showTaproom
    self.annexSwitch.isOn = filters.showAnnex
    self.eventSpaceSwitch.isOn = filters.showEventSpace
  }
  
  // MARK: Actions
  
  @IBAction func taproomTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    RareFilters.shared.showTaproom = s.isOn
    RareFilters.shared.saveFilters()
  }
  
  @IBAction func annexTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    RareFilters.shared.showAnnex = s.isOn
    RareFilters.shared.saveFilters()
  }
  
  @IBAction func eventSpaceTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    RareFilters.shared.showEventSpace = s.isOn
    RareFilters.shared.saveFilters()
  }
  
  @IBAction func closeTapped(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
}

