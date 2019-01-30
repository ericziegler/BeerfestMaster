//
//  Beer.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/8/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

let BreweryCacheKey = "BreweryCacheKey"
let BeerNameCacheKey = "BeerNameCacheKey"
let BeerStyleCacheKey = "BeerStyleCacheKey"
let ABVCacheKey = "ABVCacheKey"
let CityCacheKey = "CityCacheKey"
let StateCacheKey = "StateCacheKey"
let IsConnoissuerCacheKey = "IsConnoissuerCacheKey"
let IsEarlyAdmissionCacheKey = "IsEarlyAdmissionCacheKey"
let IsQuickPourCacheKey = "IsQuickPourCacheKey"
let MapLocationCacheKey = "MapLocationCacheKey"
let ThirdPartyStyleCacheKey = "ThirdPartyStyleCacheKey"
let ThirdPartyABVCacheKey = "ThirdPartyABVCacheKey"
let IsFavoritedCacheKey = "IsFavoritedCacheKey"
let HasTastedCacheKey = "HasTastedCacheKey"
let NoteCacheKey = "NoteCacheKey"
let RatingCacheKey = "RatingCacheKey"

class Beer: NSObject, NSCoding {
  
  // MARK: Properties
  
  var brewery: String = ""
  var name: String = ""
  private var thirdPartyStyle: String = ""
  private var privateStyle: String = ""
  var style: String {
    if !self.thirdPartyStyle.isEmpty {
      return self.thirdPartyStyle
    }
    return self.privateStyle
  }
  private var thirdPartyABV: String = ""
  private var privateABV: String = ""
  var abv: String {
    if !self.thirdPartyABV.isEmpty {
      return self.thirdPartyABV
    }
    return self.privateABV
  }
  var city: String = ""
  var state: String = ""
  var isConnoisseur: Bool = false
  var isEarlyAdmission: Bool = false
  var isQuickPour: Bool = false
  var rating: Int = -1
  var note: String = ""
  private var privateIsFavorited = false
  var isFavorited: Bool {
    return self.privateIsFavorited
  }
  private var privateHasTasted = false
  var hasTasted: Bool {
    return self.privateHasTasted
  }
  var mapLocation: String? {
    get {
      return MapLocationManager.shared.locationFor(brewery: self.brewery)
    }
  }
  
  var formattedLocation: String {
    let formattedCity = self.city.capitalized
    var formattedState = self.state
    if formattedState.count > 2 {
      formattedState = formattedState.capitalized
    } else {
      formattedState = formattedState.uppercased()
    }
    return "\(formattedCity), \(formattedState)"
  }
  
  private var analyticDictionary: [AnyHashable : Any] {
    var result = [AnyHashable : Any]()
    
    result["Brewery"] = self.brewery
    result["Beer"] = self.name
    result["Style"] = self.style
    result["ABV"] = self.abv
    result["City"] = self.city
    result["State"] = self.state
    result["Connoisseur"] = self.isConnoisseur ? "Yes" : "No"
    result["EarlyAdmission"] = self.isEarlyAdmission ? "Yes" : "No"
    result["QuickPour"] = self.isQuickPour ? "Yes" : "No"
    result["FestLocation"] = CurrentFest.displayString
    
    return result
  }
  
  // MARK: Init
  
  override init()
  {
    
  }
  
  func load(_ beerString: String) {
    if beerString.count > 0 {
      let props = beerString.components(separatedBy: ",")
      self.brewery = props[0].capitalized
      self.name = props[1].capitalized
      let specialty = props[2]
      if specialty == "E" {
        self.isEarlyAdmission = true
      }
      else if specialty == "Q" {
        self.isQuickPour = true
      }
      else if specialty == "C" {
        self.isConnoisseur = true
      }
    }
    // TODO: EZ - Standard loading. put back
//    if beerString.count > 0 {
//      let props = beerString.components(separatedBy: ",")
//      self.brewery = props[0].capitalized
//      self.name = props[1].capitalized
//      self.privateStyle = props[2]
//      self.privateABV = props[3]
//      self.city = props[4]
//      self.state = props[5]
//      let isConnoisseurString = props[6]
//      if isConnoisseurString == "1" {
//        self.isConnoisseur = true
//      }
//      let isEarlyAdmissionString = props[7]
//      if isEarlyAdmissionString == "1" {
//        self.isEarlyAdmission = true
//      }
//      let isQuickPourString = props[8]
//      if isQuickPourString == "1" {
//        self.isQuickPour = true
//      }
//      self.thirdPartyStyle = props[10]
//      self.thirdPartyABV = props[11]
//    }
  }
  
  // MARK: Analytics
  
  func toggleTasted() {
    self.privateHasTasted = !self.privateHasTasted
    BeerList.shared.saveBeersToCache()
    if self.hasTasted {
      Flurry.logEvent("Tasted", withParameters: self.analyticDictionary)
    }
  }
  
  func toggleFavorited() {
    self.privateIsFavorited = !self.isFavorited
    BeerList.shared.saveBeersToCache()
    if self.isFavorited {
      Flurry.logEvent("Favorited", withParameters: self.analyticDictionary)
    }
  }
  
  func addRating(rating: Int) {
    self.rating = rating
    BeerList.shared.saveBeersToCache()
  }
  
  func addNote(note: String) {
    self.note = note
    BeerList.shared.saveBeersToCache()
  }
  
  // MARK: NSCoding
  
  required init?(coder decoder: NSCoder) {
    if let brewery = decoder.decodeObject(forKey: BreweryCacheKey) as? String {
      self.brewery = brewery
    }
    if let name = decoder.decodeObject(forKey: BeerNameCacheKey) as? String {
      self.name = name
    }
    if let thirdPartyStyle = decoder.decodeObject(forKey: ThirdPartyStyleCacheKey) as? String {
      self.thirdPartyStyle = thirdPartyStyle
    }
    if let style = decoder.decodeObject(forKey: BeerStyleCacheKey) as? String {
      self.privateStyle = style
    }
    if let thirdPartyABV = decoder.decodeObject(forKey: ThirdPartyABVCacheKey) as? String {
      self.thirdPartyABV = thirdPartyABV
    }
    if let abv = decoder.decodeObject(forKey: ABVCacheKey) as? String {
      self.privateABV = abv
    }
    if let city = decoder.decodeObject(forKey: CityCacheKey) as? String {
      self.city = city
    }
    if let state = decoder.decodeObject(forKey: StateCacheKey) as? String {
      self.state = state
    }
    if let isConnoisseur = decoder.decodeObject(forKey: IsConnoissuerCacheKey) as? NSNumber {
      self.isConnoisseur = isConnoisseur.boolValue
    }
    if let isEarlyAdmission = decoder.decodeObject(forKey: IsEarlyAdmissionCacheKey) as? NSNumber {
      self.isEarlyAdmission = isEarlyAdmission.boolValue
    }
    if let isQuickPour = decoder.decodeObject(forKey: IsQuickPourCacheKey) as? NSNumber {
      self.isQuickPour = isQuickPour.boolValue
    }
    if let isFavorited = decoder.decodeObject(forKey: IsFavoritedCacheKey) as? NSNumber {
      self.privateIsFavorited = isFavorited.boolValue
    }
    if let hasTasted = decoder.decodeObject(forKey: HasTastedCacheKey) as? NSNumber {
      self.privateHasTasted = hasTasted.boolValue
    }
    if let rating = decoder.decodeObject(forKey: RatingCacheKey) as? NSNumber {
      self.rating = rating.intValue
    }
    if let note = decoder.decodeObject(forKey: NoteCacheKey) as? String {
      self.note = note
    }
  }
  
  public func encode(with coder: NSCoder) {
    coder.encode(self.brewery, forKey: BreweryCacheKey)
    coder.encode(self.name, forKey: BeerNameCacheKey)
    coder.encode(self.thirdPartyStyle, forKey: ThirdPartyStyleCacheKey)
    coder.encode(self.privateStyle, forKey: BeerStyleCacheKey)
    coder.encode(self.thirdPartyABV, forKey: ThirdPartyABVCacheKey)
    coder.encode(self.privateABV, forKey: ABVCacheKey)
    coder.encode(self.city, forKey: CityCacheKey)
    coder.encode(self.state, forKey: StateCacheKey)
    let isConnoisseurNumber = NSNumber(booleanLiteral: self.isConnoisseur)
    coder.encode(isConnoisseurNumber, forKey: IsConnoissuerCacheKey)
    let isEarlyAdmissionNumber = NSNumber(booleanLiteral: self.isEarlyAdmission)
    coder.encode(isEarlyAdmissionNumber, forKey: IsEarlyAdmissionCacheKey)
    let isQuickPourNumber = NSNumber(booleanLiteral: self.isQuickPour)
    coder.encode(isQuickPourNumber, forKey: IsQuickPourCacheKey)
    let isFavoritedNumber = NSNumber(booleanLiteral: self.isFavorited)
    coder.encode(isFavoritedNumber, forKey: IsFavoritedCacheKey)
    let hasTastedNumber = NSNumber(booleanLiteral: self.hasTasted)
    coder.encode(hasTastedNumber, forKey: HasTastedCacheKey)
    let ratingNumber = NSNumber(integerLiteral: self.rating)
    coder.encode(ratingNumber, forKey: RatingCacheKey)
    coder.encode(self.note, forKey: NoteCacheKey)
  }
  
}
