//
//  BeerListViewController.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/9/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let BeerListViewId = "BeerListViewId"
let TastedListViewId = "TastedListViewId"
let FavoriteListViewId = "FavoriteListViewId"

enum BeerListType: Int {
  
  case fullList
  case tasted
  case favorites
  
}

class BeerListViewController: BaseTableViewController {
  
  // MARK: Properties
  
  var listType = BeerListType.fullList
  let sectionTitles = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  
  // MARK: Init
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let storyboardId = self.restorationIdentifier {
      if storyboardId == TastedListViewId {
        self.listType = .tasted
      }
      else if storyboardId == FavoriteListViewId {
        self.listType = .favorites
      }
    }
    self.setupNavBar()
    
    self.view.backgroundColor = UIColor.mainBackground
    self.tableView.sectionIndexBackgroundColor = UIColor.clear
    self.tableView.sectionIndexColor = UIColor.accent
  }
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if (self.listType == .fullList) {
      AlphabeticalBeerList.shared.alphabetizeBeers()
    }
    self.tableView.reloadData()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return CurrentFest.preferredStatusBarStyle
  }
  
  private func setupNavBar() {
    if self.listType == .fullList {
      self.navigationItem.title = "\(CurrentFest.displayString) Beerfest"
      if let filterImage = UIImage(named: "Filter")?.maskedImageWithColor(UIColor.accent) {
        let filterButton = UIButton(type: .custom)
        filterButton.addTarget(self, action: #selector(filterTapped(_:)), for: .touchUpInside)
        filterButton.setImage(filterImage, for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: filterImage.size.width, height: filterImage.size.height)
        let filterItem = UIBarButtonItem(customView: filterButton)
        
        self.navigationItem.rightBarButtonItems = [filterItem]
      }
    }
  }
  
  // MARK: Actions
  
  @IBAction func filterTapped(_ sender: AnyObject) {
    print("filter tapped")
  }
 
  // MARK: UITableViewDataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    if (self.listType == .fullList) {
      return AlphabeticalBeerList.shared.beers.keys.count
    } else {
      return 1
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (self.listType == .fullList) {
      let key = AlphabeticalBeerList.shared.sortedKeys[section]
      return AlphabeticalBeerList.shared.beers[key]!.count
      
    }
    else if (self.listType == .tasted) {
      return TastedBeerList.shared.beers.count
    } else {
      return FavoriteBeerList.shared.beers.count
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var curBeer = Beer()
    if (self.listType == .fullList) {
      let key = AlphabeticalBeerList.shared.sortedKeys[indexPath.section]
      curBeer = AlphabeticalBeerList.shared.beers[key]![indexPath.row]
    }
    else if (self.listType == .tasted) {
      curBeer = TastedBeerList.shared.beers[indexPath.row]
    } else {
      curBeer = FavoriteBeerList.shared.beers[indexPath.row]
    }
    let beerCell: BeerCell = tableView.dequeueReusableCell(withIdentifier: BeerCellId, for: indexPath as IndexPath) as! BeerCell
    beerCell.layoutFor(beer: curBeer)
    beerCell.delegate = self
    return beerCell
  }
  
  // MARK: UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return BeerListViewCellHeight
  }
  
  override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    if (self.listType == .fullList) {
      return self.sectionTitles
    } else {
      return nil
    }
  }
  
}

extension BeerListViewController: BeerCellDelegate {
  
  func beerTastedWasToggled(_ beer: Beer, tasted: Bool, forCell: BeerCell) {
    beer.hasTasted = tasted
    BeerList.shared.saveBeersToCache()
    self.tableView.reloadData()
  }
  
  func beerFavoriteWasToggled(_ beer: Beer, favorited: Bool, forCell: BeerCell) {
    beer.isFavorited = favorited
    BeerList.shared.saveBeersToCache()
    self.tableView.reloadData()
  }
  
}
