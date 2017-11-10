//
//  SearchViewController.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/9/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let SearchViewId = "SearchViewId"
let SearchSegueId = "SearchSegueId"

class SearchViewController: UIViewController {

  // MARK: Init
  
  class func createController() -> SearchViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: SearchViewController = storyboard.instantiateViewController(withIdentifier: SearchViewId) as! SearchViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: Actions
  
  @IBAction func closeTapped(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
}

extension SearchViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SearchCellId, for: indexPath) as! SearchCell
    return cell
  }
  
}

extension SearchViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let beerVC = BeerViewController.createController()
    self.navigationController?.pushViewController(beerVC, animated: true)
  }
  
}
