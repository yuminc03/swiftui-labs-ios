//
//  AdvertisePaycoPointItem.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/28.
//

import SwiftUI

struct AdvertisePaycoPointItem: View {
  
  private let advertisePaycoPoint: AdvertisePaycoPoint
  
  init(advertisePaycoPoint: AdvertisePaycoPoint) {
    self.advertisePaycoPoint = advertisePaycoPoint
  }
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 20) {
        VStack(alignment: .leading, spacing: 10) {
          conditionText
          benefitText
        }
        deadlineText
      }
      Spacer()
      advertiseImage
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 30)
    .frame(width: UIScreen.main.bounds.width - 40, height: 220)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .fill(advertisePaycoPoint.backgroundColor)
    }
  }
}

struct AdvertisePaycoPointItem_Previews: PreviewProvider {
  static var previews: some View {
    AdvertisePaycoPointItem(advertisePaycoPoint: AdvertisePaycoPoint.dummy[0])
      .previewLayout(.sizeThatFits)
  }
}

extension AdvertisePaycoPointItem {
  
  var conditionText: some View {
    Text(advertisePaycoPoint.conditionText)
      .font(.caption)
      .fontWeight(.semibold)
      .foregroundColor(.white)
  }
  
  var benefitText: some View {
    Text(advertisePaycoPoint.benefitText)
      .font(.title2)
      .fontWeight(.semibold)
      .foregroundColor(.white)
  }
  
  var deadlineText: some View {
    Text(advertisePaycoPoint.deadlineText)
      .font(.body)
      .fontWeight(.bold)
      .foregroundColor(.white)
  }
  
  var advertiseImage: some View {
    Image(systemName: advertisePaycoPoint.imageName)
      .resizable()
      .scaledToFit()
      .frame(width: 120, height: 150)
  }
}
