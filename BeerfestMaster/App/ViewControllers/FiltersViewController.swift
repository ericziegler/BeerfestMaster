//
//  FilterViewController.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/10/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let FiltersViewId = "FiltersViewId"

class FiltersViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet weak var connoisseurSwitch: UISwitch!
  @IBOutlet weak var earlyAdmissionSwitch: UISwitch!
  @IBOutlet weak var quickPourSwitch: UISwitch!
  
  // MARK: Init
  
  class func createController() -> FiltersViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: FiltersViewController = storyboard.instantiateViewController(withIdentifier: FiltersViewId) as! FiltersViewController
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
    if let closeImage = UIImage(named: "Close")?.maskedImageWithColor(UIColor.accent) {
      let closeButton = UIButton(type: .custom)
      closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
      closeButton.setImage(closeImage, for: .normal)
      closeButton.frame = CGRect(x: 0, y: 0, width: closeImage.size.width, height: closeImage.size.height)
      let closeItem = UIBarButtonItem(customView: closeButton)
      
      self.navigationItem.rightBarButtonItems = [closeItem]
    }
  }
  
  private func setupSwitches() {
    self.connoisseurSwitch.tintColor = UIColor.connoissurBold
    self.connoisseurSwitch.onTintColor = self.connoisseurSwitch.tintColor
    self.earlyAdmissionSwitch.tintColor = UIColor.earlyAdmissionBold
    self.earlyAdmissionSwitch.onTintColor = self.earlyAdmissionSwitch.tintColor
    self.quickPourSwitch.tintColor = UIColor.quickPourBold
    self.quickPourSwitch.onTintColor = self.quickPourSwitch.tintColor
  }
  
  func updateFilters() {
    let filters = Filters.shared
    self.connoisseurSwitch.isOn = filters.showConnoisseur
    self.earlyAdmissionSwitch.isOn = filters.showEarlyAdmission
    self.quickPourSwitch.isOn = filters.showQuickPour
  }
  
  // MARK: Actions
  
  @IBAction func connoisseurTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    Filters.shared.showConnoisseur = s.isOn
    Filters.shared.saveFilters()
  }
  
  @IBAction func earlyAdmissionTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    Filters.shared.showEarlyAdmission = s.isOn
    Filters.shared.saveFilters()
  }
  
  @IBAction func quickPourTapped(_ sender: AnyObject) {
    let s = sender as! UISwitch
    Filters.shared.showQuickPour = s.isOn
    Filters.shared.saveFilters()
  }
  
  @IBAction func closeTapped(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
