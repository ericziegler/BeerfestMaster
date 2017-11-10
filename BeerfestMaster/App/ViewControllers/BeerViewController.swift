//
//  BeerViewController.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/9/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let BeerViewId = "BeerViewId"

class BeerViewController: BaseViewController {
  
  // MARK: Properties
  
  @IBOutlet var nameLabel: RegularLabel!
  @IBOutlet var styleLabel: LightLabel!
  @IBOutlet var abvLabel: LightLabel!
  @IBOutlet var breweryLabel: RegularLabel!
  @IBOutlet var cityLabel: LightLabel!
  @IBOutlet var mapView: GTZoomableImageView!
  @IBOutlet var favoriteButton: UIButton!
  @IBOutlet var tastedButton: UIButton!
  
  var beer: Beer!
  
  // MARK: Init
  
  class func createControllerFor(beer: Beer) -> BeerViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController: BeerViewController = storyboard.instantiateViewController(withIdentifier: BeerViewId) as! BeerViewController
    viewController.beer = beer
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupForBeer()
    self.styleMap()
  }
  
  private func setupForBeer() {
    self.nameLabel.text = self.beer.name
    self.breweryLabel.text = self.beer.brewery
    var formattedABV = "N/A"
    if (beer.abv != 0) {
      formattedABV = String(format: "%.01f%%", beer.abv)
    }
    self.abvLabel.text = formattedABV
    self.styleLabel.text = beer.style.replacingOccurrences(of: "NA", with: "N/A")
    self.cityLabel.text = beer.formattedLocation
    
    self.mapView.image = CurrentFest.map
    
    self.updateButtons()
  }
  
  private func styleMap() {
    self.mapView.layer.borderColor = UIColor.mediumText.cgColor
    self.mapView.layer.borderWidth = 0.5
  }
  
  private func updateButtons() {
    if self.beer.isFavorited {
      self.favoriteButton.setImage(UIImage(named: "FavoriteFilled"), for: .normal)
    } else {
      self.favoriteButton.setImage(UIImage(named: "FavoriteOutline"), for: .normal)
    }
    
    if self.beer.hasTasted {
      self.tastedButton.setImage(UIImage(named: "TastedFilled"), for: .normal)
    } else {
      self.tastedButton.setImage(UIImage(named: "TastedOutline"), for: .normal)
    }
  }
  
  // MARK: Actions
  
  @IBAction func favoriteTapped(_ sender: AnyObject) {
    beer.isFavorited = !beer.isFavorited
    BeerList.shared.saveBeersToCache()
    self.updateButtons()
  }
  
  @IBAction func tastedTapped(_ sender: AnyObject) {
    beer.hasTasted = !beer.hasTasted
    BeerList.shared.saveBeersToCache()
    self.updateButtons()
  }
  
}
