//
//  MapLocationManager.swift
//  BeerfestMaster
//
//  Created by Eric Ziegler on 1/3/18.
//  Copyright © 2018 zigabytes. All rights reserved.
//

import UIKit

class MapLocationManager {

  static let shared = MapLocationManager()
  
  var locations = [String : String]()
  
  init() {
    self.loadLocations()
  }
  
  private func loadLocations() {
    if let locationsPath = Bundle.main.path(forResource: CurrentFest.mapLocation, ofType: "csv") {
      do {
        let locationCSV = try String(contentsOfFile: locationsPath, encoding: String.Encoding.utf8)
        let locationArray = locationCSV.components(separatedBy: "\n")
        for locationItem in locationArray {
          if !locationItem.isEmpty {
            let items = locationItem.components(separatedBy: "|")
            if CurrentFest.hasBoothNumbers {
              let boothNumber = items[0]
              if UIScreen.uiKitScreenSize == iPhone678Size {
                self.locations[boothNumber] = items[1]
              }
              else if UIScreen.uiKitScreenSize == iPhone678PlusSize {
                self.locations[boothNumber] = items[2]
              }
              else if UIScreen.uiKitScreenSize == iPhoneXSize {
                self.locations[boothNumber] = items[3]
              }
              else {
                // iPhone 5 / iPadSize
                self.locations[boothNumber] = items[4]
              }
            } else {
              let brewery = items[0].replacingOccurrences(of: "'", with: "").replacingOccurrences(of: " ", with: "").lowercased()
              if UIScreen.uiKitScreenSize == iPhone678Size {
                self.locations[brewery] = items[1]
              }
              else if UIScreen.uiKitScreenSize == iPhone678PlusSize {                
                self.locations[brewery] = items[2]
              }
              else if UIScreen.uiKitScreenSize == iPhoneXSize {
                self.locations[brewery] = items[3]
              }
              else {
                // iPhone 5 / iPadSize                
                self.locations[brewery] = items[4]
              }
            }
          }
        }

      } catch{
        debugPrint(error)
      }
    }
  }
  
  func locationFor(brewery: String) -> String {
    let formattedBrewery = brewery.replacingOccurrences(of: "'", with: "").replacingOccurrences(of: " ", with: "").lowercased()
    for curItem in Array(self.locations.keys) {      
      if curItem.contains(formattedBrewery) {
        return self.locations[curItem]!
      }
    }
    return ""
  }
  
  func locationFor(boothNumber: String) -> String {
    for curItem in Array(self.locations.keys) {
      if curItem == boothNumber {
        return self.locations[curItem]!
      }
    }
    return ""
  }
  
}
