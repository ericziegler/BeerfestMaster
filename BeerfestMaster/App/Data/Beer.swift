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
let IsFavoritedCacheKey = "IsFavoritedCacheKey"
let HasTastedCacheKey = "HasTastedCacheKey"

class Beer: NSObject, NSCoding {
  
  // MARK: Properties
  
  var brewery: String = ""
  var name: String = ""
  var style: String = ""
  var abv: Double = 0.0
  var city: String = ""
  var state: String = ""
  var isConnoisseur: Bool = false
  var isEarlyAdmission: Bool = false
  var isQuickPour: Bool = false
  var isFavorited: Bool = false
  var hasTasted: Bool = false
  
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
  
  // MARK: Init
  
  override init()
  {
    
  }
  
  func load(_ beerString: String) {
    if beerString.characters.count > 0 {
      let props = beerString.components(separatedBy: ",")
      self.brewery = props[0].capitalized
      self.name = props[1].capitalized
      self.style = props[2]
      let abvString = props[3]
      if let abvValue = Double(abvString) {
        self.abv = abvValue
      }
      self.city = props[4]
      self.state = props[5]
      let isConnoisseurString = props[6]
      if isConnoisseurString == "1" {
        self.isConnoisseur = true
      }
      let isEarlyAdmissionString = props[7]
      if isEarlyAdmissionString == "1" {
        self.isEarlyAdmission = true
      }
      let isQuickPourString = props[8]
      if isQuickPourString == "1" {
        self.isQuickPour = true
      }
    }
  }
  
  // MARK: NSCoding
  
  required init?(coder decoder: NSCoder) {
    if let brewery = decoder.decodeObject(forKey: BreweryCacheKey) as? String {
      self.brewery = brewery
    }
    if let name = decoder.decodeObject(forKey: BeerNameCacheKey) as? String {
      self.name = name
    }
    if let style = decoder.decodeObject(forKey: BeerStyleCacheKey) as? String {
      self.style = style
    }
    if let abv = decoder.decodeObject(forKey: ABVCacheKey) as? NSNumber {
      self.abv = abv.doubleValue
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
      self.isFavorited = isFavorited.boolValue
    }
    if let hasTasted = decoder.decodeObject(forKey: HasTastedCacheKey) as? NSNumber {
      self.hasTasted = hasTasted.boolValue
    }
  }
  
  public func encode(with coder: NSCoder) {
    coder.encode(self.brewery, forKey: BreweryCacheKey)
    coder.encode(self.name, forKey: BeerNameCacheKey)
    coder.encode(self.style, forKey: BeerStyleCacheKey)
    let abvNumber = NSNumber(value: self.abv)
    coder.encode(abvNumber, forKey: ABVCacheKey)
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
  }
  
}
