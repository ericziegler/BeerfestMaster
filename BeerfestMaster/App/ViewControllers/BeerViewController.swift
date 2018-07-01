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
  @IBOutlet var commentView: UIView!
  @IBOutlet var commentLabel: UILabel!
  
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
    self.styleCommentBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.scrollToLocation()
  }
  
  private func setupForBeer() {
    self.nameLabel.text = self.beer.name
    if beer.boothNumber.isEmpty {
      self.breweryLabel.text = self.beer.brewery
    } else {
      self.breweryLabel.text = "\(self.beer.brewery) (Booth \(self.beer.boothNumber))"
    }
    self.abvLabel.text = beer.abv
    self.styleLabel.text = beer.style
    self.cityLabel.text = beer.formattedLocation
    
    self.updateButtons()
  }
  
  private func styleCommentBar() {
    self.commentLabel.textColor = UIColor.accent
  }
  
  private func scrollToLocation() {
    var rect = CGRect.zero
    if let location = MapLocationManager.shared.locationFor(boothNumber: self.beer.boothNumber) {
      let coords = location.components(separatedBy: ",")
      if coords.count > 3 {
        let numberFormatter = NumberFormatter()
        if let xCoord = numberFormatter.number(from: coords[0]), let yCoord = numberFormatter.number(from: coords[1]),
          let width = numberFormatter.number(from: coords[2]), let height = numberFormatter.number(from: coords[3]) {          
          rect = CGRect(x: CGFloat(truncating: xCoord), y: CGFloat(truncating: yCoord), width: CGFloat(truncating: width), height: CGFloat(truncating: height))
          if rect != CGRect.zero {
            self.mapView.zoom(to: rect, animated: true)
          }
        }
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
  
  @IBAction func commentTapped(_ sender: AnyObject) {
    let noteViewController = NoteViewController.createControllerFor(beer: beer)
    self.navigationController?.pushViewController(noteViewController, animated: true)
  }
  
}

extension BeerViewController: UIScrollViewDelegate {

  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.mapImageView
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print("\(scrollView.contentOffset.x),\(scrollView.contentOffset.y),\(scrollView.bounds.width),\(scrollView.bounds.height)|")
  }
  
}
