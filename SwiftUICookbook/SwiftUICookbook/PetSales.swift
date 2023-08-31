//
//  PetSales.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/08/31.
//

import Foundation

enum Pet: String {
  case dog, cat, bird, fish
}

struct PetSales: Identifiable {
  let month: String
  let animal: Pet
  let value: Double
  let id = UUID()
}
