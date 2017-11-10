//
//  AlphabeticalBeerList.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/8/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

// MARK: Constants

let NumberString = "0123456789"

class AlphabeticalBeerList {
  
  // MARK: Properties
  
  var sortedKeys = [String]()
  var beers =  [String : [Beer]]()
  
  // MARK: Init
  
  static let shared = AlphabeticalBeerList()
  
  init() {
    self.alphabetizeBeers()
  }
  
  func alphabetizeBeers() {
    self.sortedKeys = [String]()
    self.beers = [String : [Beer]]()
    
    let unsortedBeers = BeerList.shared.filteredBeers
    
    self.beers["#"] = [Beer]()
    
    for curBeer in unsortedBeers {
      if let firstChar = curBeer.brewery.characters.first {
        let charString = String(firstChar)
        if (self.beers.keys.contains(charString)) {
          self.beers[charString]?.append(curBeer)
        } else {
          if (NumberString.contains(charString)) {
            self.beers["#"]?.append(curBeer)
          } else {
            self.beers[charString] = [Beer]()
            self.beers[charString]?.append(curBeer)
          }
        }
      }
    }
    self.sortedKeys = Array(self.beers.keys).sorted(by: <)
  }
  
}
