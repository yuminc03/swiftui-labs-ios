//
//  SearchCityRow.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/04.
//

import SwiftUI

struct SearchCityRow: View {
  private let city: CityGroup.City
  
  init(city: CityGroup.City) {
    self.city = city
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Text(city.name)
          .font(.body)
        Spacer()
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
    .contentShape(Rectangle())
  }
}

struct SearchCityRow_Previews: PreviewProvider {
  static var previews: some View {
    SearchCityRow(city: CityGroup.dummy[0].cities[0])
      .previewLayout(.sizeThatFits)
  }
}
