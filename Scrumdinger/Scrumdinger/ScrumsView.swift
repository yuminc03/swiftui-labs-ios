//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Yumin Chu on 2023/08/24.
//

import SwiftUI

struct ScrumsView: View {
  let scrums: [DailyScrum]
  
  var body: some View {
    Text("Hello, World!")
  }
}

struct ScrumsView_Previews: PreviewProvider {
  static var previews: some View {
    ScrumsView(scrums: DailyScrum.sampleData)
  }
}
