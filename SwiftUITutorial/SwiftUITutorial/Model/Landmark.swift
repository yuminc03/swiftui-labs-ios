//
//  Landmark.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
  let id: Int
  let name: String
  let park: String
  let state: String
  let description: String
  var isFavorite: Bool
  let isFeatured: Bool
  
  let category: Category
  enum Category: String, CaseIterable, Codable {
    case lakes = "Lakes"
    case rivers = "Rivers"
    case mountains = "Mountains"
  }
  
  private let imageName: String
  var image: Image {
    Image(imageName)
  }
  var featureImage: Image? {
    isFeatured ? Image(imageName + "_feature") : nil
  }
  
  private let coordinates: Coordinates
  var locationCoordicate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude
    )
  }
  struct Coordinates: Hashable, Codable {
    let latitude: Double
    let longitude: Double
  }
}
