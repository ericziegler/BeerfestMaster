//
//  BeerCell.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/9/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import UIKit

// MARK: Constants

let BeerCellId = "BeerCellId"
let BeerListViewCellHeight: CGFloat = 88.0

// MARK: Protocol

protocol BeerCellDelegate {
  func beerTastedWasToggled(_ beer: Beer, tasted: Bool, forCell: BeerCell)
  func beerFavoriteWasToggled(_ beer: Beer, favorited: Bool, forCell: BeerCell)
}

class BeerCell: UITableViewCell {
  
  // MARK: Properties
  
  @IBOutlet weak var breweryLabel: RegularLabel!
  @IBOutlet weak var nameLabel: LightLabel!
  @IBOutlet weak var styleLabel: LightLabel!
  @IBOutlet weak var locationLabel: LightLabel!
  @IBOutlet weak var tastedButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
  var beer: Beer?
  var delegate: BeerCellDelegate?
  
  // MARK: Actions
  
  @IBAction func tastedTapped(_ sender: AnyObject) {
    if let b = self.beer, let d = self.delegate {
      d.beerTastedWasToggled(b, tasted: !b.hasTasted, forCell: self)
    }
  }
  
  @IBAction func favoriteTapped(_ sender: AnyObject) {
    if let b = self.beer, let d = self.delegate {
      d.beerFavoriteWasToggled(b, favorited: !b.isFavorited, forCell: self)
    }
  }
  
  // MARK: Layout
  
  func layoutFor(beer: Beer) {    
    self.beer = beer
    
    self.breweryLabel.text = beer.brewery
    self.nameLabel.text = beer.name
    
    self.styleLabel.text = String(format: "%@ • %@", beer.style, beer.abv)
    self.locationLabel.text = beer.formattedLocation
    
    if (beer.isFavorited) {
      self.favoriteButton.setImage(UIImage(named: "FavoriteFilled"), for: .normal)
    } else {
      self.favoriteButton.setImage(UIImage(named: "FavoriteOutline"), for: .normal)
    }
    
    if (beer.hasTasted) {
      self.tastedButton.setImage(UIImage(named: "TastedFilled"), for: .normal)
    } else {
      self.tastedButton.setImage(UIImage(named: "TastedOutline"), for: .normal)
    }
    
    if (beer.isConnoisseur) {
      self.backgroundColor = UIColor.connoissur
    }
    else if (beer.isEarlyAdmission) {
      self.backgroundColor = UIColor.earlyAdmission
    }
    else if (beer.isQuickPour) {
      self.backgroundColor = UIColor.quickPour
    } else {
      self.backgroundColor = UIColor.mainBackground
    }
  }
  
}
