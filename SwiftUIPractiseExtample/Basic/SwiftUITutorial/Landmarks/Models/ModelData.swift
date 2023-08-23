//
//  ModelData.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/23.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
  @Published var landmarks: [Landmark] = load("landmarkData.json")
  var hikes: [Hike] = load("hikeData.json")
  
  var categories: [String: [Landmark]] {
    Dictionary(grouping: landmarks, by: { $0.category.rawValue })
  }
}

func loadLandmarkData<T: Decodable>(_ fileName: String) -> T {
  let data: Data
  
  guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
    fatalError("Couldn't find \(fileName) in main bundle.")
  }
  
  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Couldn't load \(fileName) from main bundle: \n\(error)")
  }
  
  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
  }
}
