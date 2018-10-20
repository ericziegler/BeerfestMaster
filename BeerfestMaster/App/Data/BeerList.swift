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
    
    if CurrentFest == .rarebeerfest {
      let filters = RareFilters.shared
      for curBeer in self.beers {
        canAddBeer = true
        
        if (filters.showTaproom == false && curBeer.boothNumber == "0") {
          canAddBeer = false
        }
        else if (filters.showAnnex == false && curBeer.boothNumber == "1") {
          canAddBeer = false
        }
        else if (filters.showEventSpace == false && curBeer.boothNumber == "2") {
          canAddBeer = false
        }
        
        if (canAddBeer) {
          result.append(curBeer)
        }
      }
    } else {
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
    if self.shouldLoadBeersFromCache() == false {
      self.loadBeersFromCSV()
      self.purgeFavoritesAndTasted()
    } else {
      if self.loadBeersFromCache() == false {
        self.loadBeersFromCSV()
      }
    }
    saveAppVersionNumber()
  }
  
  private func shouldLoadBeersFromCache() -> Bool {        
    if loadAppVersionNumber() == versionNumber {
      return true
    } else {
      return false
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
    
    if let beerPath = Bundle.main.path(forResource: CurrentFest.listFile, ofType: "csv") {
      self.loadBeersFromFile(beerPath)
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
  
  func purgeFavoritesAndTasted() {
    for beer in self.beers {
      beer.purgeAnalytics()
    }
    self.saveBeersToCache()
  }
  
  // MARK: Saving
  
  func saveBeersToCache() {
    let beerListData = NSKeyedArchiver.archivedData(withRootObject: self.beers)
    UserDefaults.standard.set(beerListData, forKey: BeerListCacheKey)
  }
  
}
