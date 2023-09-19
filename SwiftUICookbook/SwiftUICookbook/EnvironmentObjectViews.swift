//
//  EnvironmentObjectViews.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/15.
//

import SwiftUI

class GameSettings: ObservableObject {
  @Published var score = 0
}

struct EnvironmentObjectViews: View {
  var body: some View {
    GameView()
      .environmentObject(GameSettings())
  }
}

struct EnvironmentObjectViews_Previews: PreviewProvider {
  static var previews: some View {
    EnvironmentObjectViews()
  }
}

struct GameView: View {
  @EnvironmentObject var settings: GameSettings
  
  var body: some View {
    VStack {
      Text("Score: \(settings.score)")
      Button("Increment Score") {
        settings.score += 1
      }
    }
  }
}
