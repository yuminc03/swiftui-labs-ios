//
//  VideoView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 1/21/24.
//

import SwiftUI

struct VideoView: View {
  @State private var videoName = "my_army_log"
  
  var body: some View {
    VStack {
      RepresentedPlayerView(videoName: $videoName)
        .frame(height: 200)
      Spacer()
      Button {
        videoName = "FastTyping"
      } label: {
        Text("Next Video")
      }
    }
  }
}

struct VideoView_Previews: PreviewProvider {
  static var previews: some View {
    VideoView()
  }
}
