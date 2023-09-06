//
//  SearchCityRow.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/04.
//

import SwiftUI

struct SearchCityRow: View {
  private let city: City
  
  init(city: City) {
    self.city = city
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(city.name)
        .font(.body)
      Divider()
        .background(.gray)
    }
    .padding(.horizontal, 20)
    .padding(.top, 10)
  }
}

struct SearchCityRow_Previews: PreviewProvider {
  static var previews: some View {
    SearchCityRow(city: City.dummy[0])
      .previewLayout(.sizeThatFits)
  }
}
