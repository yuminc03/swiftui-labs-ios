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
    NavigationStack {
      List(scrums) { scrum in
        NavigationLink {
          DetailView(scrum: scrum)
        } label: {
          CardView(scrum: scrum)
        }
        .listRowBackground(scrum.theme.mainColor)
      }
      .navigationTitle("Daily Scrums")
      .toolbar {
        Button {
          
        } label: {
          Image(systemName: "plus")
        }
        .accessibilityLabel("New Scrum")
      }
    }
  }
}

struct ScrumsView_Previews: PreviewProvider {
  static var previews: some View {
    ScrumsView(scrums: DailyScrum.sampleData)
  }
}
