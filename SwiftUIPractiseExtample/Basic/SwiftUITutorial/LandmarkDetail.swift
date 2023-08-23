//
//  LandmarkDetail.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/23.
//

import SwiftUI

struct LandmarkDetail: View {
  let landmark: Landmark
  
  var body: some View {
    ScrollView {
      MapView(coordinate: landmark.locationCoordicate)
        .ignoresSafeArea(edges: .top)
        .frame(height: 300)
      
      CircleImage(image: landmark.image)
        .offset(y: -130)
        .padding(.bottom, -130)
      
      VStack(alignment: .leading) {
        Text(landmark.name)
          .font(.title)
        HStack {
          Text(landmark.park)
          Spacer()
          Text(landmark.state)
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
        
        Divider()
        
        Text("About \(landmark.name)")
          .font(.title2)
        Text(landmark.description)
      }
      .padding()
    }
    .navigationTitle(landmark.name)
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct LandmarkDetail_Previews: PreviewProvider {
  static var previews: some View {
    LandmarkDetail(landmark: landmarks[0])
  }
}
