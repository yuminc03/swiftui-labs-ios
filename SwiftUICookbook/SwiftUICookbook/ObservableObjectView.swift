//
//  ObservableObjectView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/15.
//

import SwiftUI

class UserSettings: ObservableObject {
  @Published var username = "Anonymous"
}

struct ObservableObjectView: View {
  @ObservedObject var settings = UserSettings()
  
  var body: some View {
    VStack {
      Text("Hello, \(settings.username)")
      Button("Change Username") {
        settings.username = "Yumin"
      }
    }
  }
}

struct ObservableObjectView_Previews: PreviewProvider {
  static var previews: some View {
    ObservableObjectView()
  }
}
