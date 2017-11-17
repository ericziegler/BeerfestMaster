//
//  BeerList.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/8/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

let BeerListCacheKey = "BeerListCacheKey"

class BeerList {
  
  // MARK: Properties
  
  var beers: [Beer] = []
  var filteredBeers: [Beer] {
    var result = [Beer]()
    var canAddBeer = true
    let filters = Filters.shared
    
    for curBeer in self.beers {
      canAddBeer = true
      
      if (filters.showConnoisseur == false && curBeer.isConnoisseur) {
        canAddBeer = false
      }
      else if (filters.showEarlyAdmission == false && curBeer.isEarlyAdmission) {
        canAddBeer = false
      }
      else if (filters.showQuickPour == false && curBeer.isQuickPour) {
        canAddBeer = false
      }
      
      if (canAddBeer) {
        result.append(curBeer)
      }
    }
    
    return result
  }
  
  // MARK: Init
  
  static let shared = BeerList()
  
  init() {
    self.loadBeers()
  }
  
  // MARK: Loading
  
  func loadBeers() {
    if self.loadBeersFromCache() == false {
      self.loadBeersFromCSV()
      // TODO: EZ - Comment in the caching of beer data
      //self.saveBeersToCache()
    }
  }
  
  private func loadBeersFromCache() -> Bool {
    var result = false
    
    if let beerListData = UserDefaults.standard.data(forKey: BeerListCacheKey) {
      if let beers = NSKeyedUnarchiver.unarchiveObject(with: beerListData) as? [Beer] {
        self.beers = beers
        result = true
      }
    }
    
    return result
  }
  
  private func loadBeersFromCSV() {
    self.beers = []
    
    if let beerPath = Bundle.main.path(forResource: "beerlist", ofType: "csv") {
      self.loadBeersFromFile(beerPath)
    }
    if let specialBeerPath = Bundle.main.path(forResource: "specialbeerlist", ofType: "csv") {
      self.loadBeersFromFile(specialBeerPath)
    }
    
    self.beers.sort {
      $0.brewery < $1.brewery
    }
  }
  
  private func loadBeersFromFile(_ fileName: String) {
    do {
      let beerCSV = try String(contentsOfFile: fileName, encoding: String.Encoding.utf8)
      let beerArray = beerCSV.components(separatedBy: "\n")
      for beerItem in beerArray {
        let beer = Beer()
        beer.load(beerItem)
        if (beer.name.count > 0) {
          self.beers.append(beer)
        }
      }
      
    } catch{
      debugPrint(error)
    }
  }
  
  // MARK: Saving
  
  func saveBeersToCache() {
    let beerListData = NSKeyedArchiver.archivedData(withRootObject: self.beers)
    UserDefaults.standard.set(beerListData, forKey: BeerListCacheKey)
  }
  
}
