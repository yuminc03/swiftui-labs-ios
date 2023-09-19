//
//  EnvironmentValuesView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/17.
//

import SwiftUI

struct ThemeKey: EnvironmentKey {
  static let defaultValue: Theme = .light
}

extension EnvironmentValues {
  var theme: Theme {
    get { self[ThemeKey.self] }
    set { self[ThemeKey.self] = newValue }
  }
}

enum Theme {
  case light, dark
}

extension View {
  func theme(_ theme: Theme) -> some View {
    environment(\.theme, theme)
  }
}

struct ThemedView: View {
  @Environment(\.theme) var theme: Theme
  
  var body: some View {
    VStack {
      if theme == .light {
        Text("Light Theme")
          .foregroundColor(.black)
          .background(.white)
      } else {
        Text("Dark Theme")
          .foregroundColor(.white)
          .background(.black)
      }
    }
    .padding()
  }
}

struct EnvironmentValuesView: View {
  @State var theme: Theme = .light
  
  var body: some View {
    VStack {
      Button("Switch Theme") {
        switch theme {
        case .light:
          theme = .light
          
        case .dark:
          theme = .dark
        }
      }
      ThemedView()
    }
    .theme(theme)
  }
}

struct EnvironmentValuesView_Previews: PreviewProvider {
  static var previews: some View {
    EnvironmentValuesView()
  }
}
