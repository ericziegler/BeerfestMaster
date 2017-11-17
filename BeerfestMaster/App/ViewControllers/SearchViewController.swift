//
//  SearchViewController.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/10/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let SearchViewId = "SearchViewId"

class SearchViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet var searchIcon: UIImageView!
  @IBOutlet var searchTextField: UITextField!
  @IBOutlet var searchTable: UITableView!
  @IBOutlet var searchTableBottomConstraint: NSLayoutConstraint!
  
  let searchManager = SearchManager()
  
  // MARK: Init
  
  class func createController() -> SearchViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: SearchViewController = storyboard.instantiateViewController(withIdentifier: SearchViewId) as! SearchViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.searchIcon.image = self.searchIcon.image?.maskedImageWithColor(UIColor(hex: 0xc7c7cd))
    self.searchTextField.becomeFirstResponder()
    self.setupNavBar()
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  private func setupNavBar() {
    if let closeImage = UIImage(named: "Close")?.maskedImageWithColor(UIColor.accent) {
      let closeButton = UIButton(type: .custom)
      closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .touchUpInside)
      closeButton.setImage(closeImage, for: .normal)
      closeButton.frame = CGRect(x: 0, y: 0, width: closeImage.size.width, height: closeImage.size.height)
      let closeItem = UIBarButtonItem(customView: closeButton)
      
      self.navigationItem.rightBarButtonItems = [closeItem]
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: Actions
  
  @IBAction func closeTapped(_ sender: AnyObject) {
    self.view.endEditing(true)
  }
  
  // MARK: Notifications
  
  @objc func handleKeyboardWillShowNotification(_ notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo!
    let kbSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
    let duration: NSNumber = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber)
    
    UIView.animate(withDuration: TimeInterval(truncating: duration), animations: {
      var tabBarHeight: CGFloat = 0
      if let calculatedTabHeight = self.tabBarController?.tabBar.bounds.size.height {
        tabBarHeight = calculatedTabHeight
      }
      self.searchTableBottomConstraint.constant = kbSize.height + tabBarHeight
      self.view.layoutIfNeeded()
    })
  }
  
  @objc func handleKeyboardWillHideNotification(_ notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo!
    let duration: NSNumber = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber)
    
    UIView.animate(withDuration: TimeInterval(truncating: duration), animations: {
      self.searchTableBottomConstraint.constant = 0
      self.view.layoutIfNeeded()
    })
  }
  
}

extension SearchViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let updatedString = textField.text!.replacingCharacters(in: range.toRange(textField.text!), with: string) as String
    self.searchManager.performSearch(for: updatedString)
    self.searchTable.reloadData()
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    self.searchManager.clearData()
    self.searchTable.reloadData()
    return true
  }
  
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
  
  // MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (section == 0) {
      return self.searchManager.breweries.count
    }
    else if (section == 1) {
      return self.searchManager.beers.count
    }
    else if (section == 2) {
      return self.searchManager.styles.count
    } else {
      return self.searchManager.cities.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var curBeer = Beer()
    
    if (indexPath.section == 0) {
      curBeer = self.searchManager.breweries[indexPath.row]
    }
    else if (indexPath.section == 1) {
      curBeer = self.searchManager.beers[indexPath.row]
    }
    else if (indexPath.section == 2) {
      curBeer = self.searchManager.styles[indexPath.row]
    } else {
      curBeer = self.searchManager.cities[indexPath.row]
    }
    let beerCell: BeerCell = tableView.dequeueReusableCell(withIdentifier: BeerCellId, for: indexPath as IndexPath) as! BeerCell
    beerCell.layoutFor(beer: curBeer)
    beerCell.delegate = self
    
    return beerCell
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return BeerListViewCellHeight
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var result: String?
    
    if (section == 0 && self.searchManager.breweries.count > 0) {
      result = "Breweries"
    }
    else if (section == 1 && self.searchManager.beers.count > 0) {
      result = "Beers"
    }
    else if (section == 2 && self.searchManager.styles.count > 0) {
      result = "Styles"
    }
    else if (section == 3 && self.searchManager.cities.count > 0) {
      result = "Cities"
    }
    
    return result
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var curBeer: Beer?
    
    if (indexPath.section == 0) {
      curBeer = self.searchManager.breweries[indexPath.row]
    }
    else if (indexPath.section == 1) {
      curBeer = self.searchManager.beers[indexPath.row]
    }
    else if (indexPath.section == 2) {
      curBeer = self.searchManager.styles[indexPath.row]
    } else {
      curBeer = self.searchManager.cities[indexPath.row]
    }
    
    if let curBeer = curBeer {
      let beerController = BeerViewController.createControllerFor(beer: curBeer)
      self.navigationController?.pushViewController(beerController, animated: true)
    } else {
      let alert = UIAlertController(title: "Error Loading Beer", message: "Sorry! We were unable to find information on this beer.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
}

extension SearchViewController: BeerCellDelegate {
  
  func beerTastedWasToggled(_ beer: Beer, tasted: Bool, forCell: BeerCell) {
    beer.hasTasted = tasted
    BeerList.shared.saveBeersToCache()
    self.searchTable.reloadData()
  }
  
  func beerFavoriteWasToggled(_ beer: Beer, favorited: Bool, forCell: BeerCell) {
    beer.isFavorited = favorited
    BeerList.shared.saveBeersToCache()
    self.searchTable.reloadData()
  }
  
}

