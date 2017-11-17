//
//  SearchManager.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 11/8/17.
//  Copyright © 2017 zigabytes. All rights reserved.
//

import Foundation

class SearchManager {
  
  // MARK: Properties
  
  var breweries = [Beer]()
  var beers = [Beer]()
  var styles = [Beer]()
  var cities = [Beer]()
  
  // MARK: Search
  
  func performSearch(for text: String) {
    self.clearData()
    
    if (text.count > 2) {
      let lowercaseText = text.lowercased()
      let list = BeerList.shared.beers
      
      for curBeer in list {
        // search breweries
        if (curBeer.brewery.lowercased().hasPrefix(lowercaseText)) {
          self.breweries.append(curBeer)
        }
        // search beer names
        if (curBeer.name.lowercased().hasPrefix(lowercaseText)) {
          self.beers.append(curBeer)
        }
        // search styles
        if (curBeer.style.lowercased().contains(lowercaseText)) {
          self.styles.append(curBeer)
        }
        // search cities
        if (curBeer.city.lowercased().hasPrefix(lowercaseText)) {
          self.cities.append(curBeer)
        }
      }
    }
  }
  
  func clearData() {
    self.breweries.removeAll()
    self.beers.removeAll()
    self.styles.removeAll()
    self.cities.removeAll()
  }
  
}
