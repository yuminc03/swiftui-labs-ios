//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Yumin Chu on 2023/08/24.
//

import SwiftUI

struct ScrumsView: View {
  @Binding var scrums: [DailyScrum]
  @State private var isPresentingNewScrumView = false
  
  var body: some View {
    NavigationStack {
      List($scrums) { $scrum in
        NavigationLink {
          DetailView(scrum: $scrum)
        } label: {
          CardView(scrum: scrum)
        }
        .listRowBackground(scrum.theme.mainColor)
      }
      .navigationTitle("Daily Scrums")
      .toolbar {
        Button {
          isPresentingNewScrumView = true
        } label: {
          Image(systemName: "plus")
        }
        .accessibilityLabel("New Scrum")
      }
    }
    .sheet(isPresented: $isPresentingNewScrumView) {
      NewScrumSheet(
        scrums: $scrums,
        isPresentingNewScrumView: $isPresentingNewScrumView
      )
    }
  }
}

struct ScrumsView_Previews: PreviewProvider {
  static var previews: some View {
    ScrumsView(scrums: .constant(DailyScrum.sampleData))
  }
}
