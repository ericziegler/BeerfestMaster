//
//  TastedBeerList.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/8/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

class TastedBeerList {
  
  // MARK: Properties
  
  var beers: [Beer] {
    get {
      var result = [Beer]()
      
      for curBeer in BeerList.shared.filteredBeers {
        if (curBeer.hasTasted) {
          result.append(curBeer)
        }
      }
      
      return result
    }
  }
  
  // MARK: Init
  
  static let shared = TastedBeerList()
  
}
