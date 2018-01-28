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
  @IBOutlet var mapView: UIScrollView!
  @IBOutlet var favoriteButton: UIButton!
  @IBOutlet var tastedButton: UIButton!
  @IBOutlet var mapTapGestureRecognizer: UITapGestureRecognizer!
  
  var beer: Beer!
  var mapImageView: UIImageView!
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.scrollToLocation()
  }
  
  private func setupForBeer() {
    self.nameLabel.text = self.beer.name
    self.breweryLabel.text = self.beer.brewery
    self.abvLabel.text = beer.abv
    self.styleLabel.text = beer.style
    self.cityLabel.text = beer.formattedLocation
    
    self.updateButtons()
  }
  
  private func scrollToLocation() {
    var point = CGPoint.zero
    
    if let location = self.beer.mapLocation {
      if CurrentFest == .philadelphia {
        if location == "0" {
          point = CGPoint(x: 0, y: 0)
        }
        else if location == "1" {
          point = CGPoint(x: 0, y: 425)
        }
        else if location == "2" {
          point = CGPoint(x: 140, y: 0)
        }
        else if location == "3" {
          point = CGPoint(x: 140, y: 425)
        }
        else if location == "4" {
          point = CGPoint(x: 415, y: 0)
        }
        else if location == "5" {
          point = CGPoint(x: 415, y: 400)
        }
        else if location == "6" {
          point = CGPoint(x: 540, y: 0)
        }
        else if location == "7" {
          point = CGPoint(x: 540, y: 425)
        }
        let rect = CGRect(x: point.x - 100, y: point.y - 100, width: point.x + 200, height: point.y + 200)
        self.mapView.zoom(to: rect, animated: false)
      }
      else if CurrentFest == .columbus {
        if location == "0" {
          point = CGPoint(x: 182, y: 14)
        }
        else if location == "1" {
          point = CGPoint(x: 151, y: 494)
        }
        else if location == "2" {
          point = CGPoint(x: 69, y: 863)
        }
        else if location == "3" {
          point = CGPoint(x: 491, y: 147)
        }
        else if location == "4" {
          point = CGPoint(x: 570, y: 601)
        }
        else if location == "5" {
          point = CGPoint(x: 587, y: 901)
        }
        let rect = CGRect(x: point.x, y: point.y, width: 350, height: 350)
        self.mapView.zoom(to: rect, animated: false)
      }
      else if CurrentFest == .cleveland {
        if location == "0" {
          point = CGPoint(x: 58, y: 57)
        }
        else if location == "1" {
          point = CGPoint(x: 145, y: 504)
        }
        else if location == "2" {
          point = CGPoint(x: 153, y: 937)
        }
        else if location == "3" {
          point = CGPoint(x: 484, y: 136)
        }
        else if location == "4" {
          point = CGPoint(x: 522, y: 569)
        }
        else if location == "5" {
          point = CGPoint(x: 522, y: 957)
        }
        else if location == "6" {
          point = CGPoint(x: 686, y: 43)
        }
        else if location == "7" {
          point = CGPoint(x: 686, y: 527)
        }
        else if location == "8" {
          point = CGPoint(x: 686, y: 952)
        }
        let rect = CGRect(x: point.x, y: point.y, width: 470, height: 470)
        self.mapView.zoom(to: rect, animated: false)
      }
      else if CurrentFest == .cincinnati {
        if location == "0" {
          point = CGPoint(x: 400, y: 285)
        }
        else if location == "1" {
          point = CGPoint(x: 432, y: 627)
        }
        else if location == "2" {
          point = CGPoint(x: 465, y: 982)
        }
        else if location == "3" {
          point = CGPoint(x: 453, y: 1419)
        }
        else if location == "4" {
          point = CGPoint(x: 398, y: 1786)
        }
        else if location == "5" {
          point = CGPoint(x: 737, y: 190)
        }
        else if location == "6" {
          point = CGPoint(x: 763, y: 553)
        }
        else if location == "7" {
          point = CGPoint(x: 765, y: 924)
        }
        else if location == "8" {
          point = CGPoint(x: 723, y: 1407)
        }
        else if location == "9" {
          point = CGPoint(x: 790, y: 1673)
        }
        else if location == "10" {
          point = CGPoint(x: 896, y: 1655)
        }
        else if location == "11" {
          point = CGPoint(x: 912, y: 1916)
        }
        else if location == "12" {
          point = CGPoint(x: 488, y: 1408)
        }
        let rect = CGRect(x: point.x, y: point.y, width: 470, height: 470)
        self.mapView.zoom(to: rect, animated: false)
      }
    }
  }
  
  private func styleMap() {
    self.mapView.layer.borderColor = UIColor.mediumText.cgColor
    self.mapView.layer.borderWidth = 0.5
    
    self.mapImageView = UIImageView(image: CurrentFest.map)
    self.mapView.addSubview(self.mapImageView)
    self.mapView.contentSize = self.mapImageView.bounds.size
    self.mapView.clipsToBounds = true
    self.mapView.maximumZoomScale = 2.5
    
    self.mapTapGestureRecognizer.numberOfTapsRequired = 2
  }
  
  @IBAction func mapTapped(_ sender: UITapGestureRecognizer) {
    let point = sender.location(in: self.mapImageView)
    self.zoomToPoint(point: point)
  }
  
  private func zoomToPoint(point: CGPoint) {
    let scale = min(self.mapView.zoomScale * 2, self.mapView.maximumZoomScale)
      if scale != self.mapView.zoomScale {
      let scrollSize = self.mapView.frame.size
      let size = CGSize(width: scrollSize.width / scale,
                        height: scrollSize.height / scale)
      let origin = CGPoint(x: point.x - size.width / 2,
                           y: point.y - size.height / 2)
      self.mapView.zoom(to:CGRect(origin: origin, size: size), animated: true)
    }
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
    beer.toggleFavorited()
    BeerList.shared.saveBeersToCache()
    self.updateButtons()
  }
  
  @IBAction func tastedTapped(_ sender: AnyObject) {
    beer.toggleTasted()
    BeerList.shared.saveBeersToCache()
    self.updateButtons()
  }
  
}

extension BeerViewController: UIScrollViewDelegate {

  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.mapImageView
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(scrollView.contentOffset)
  }
  
}
