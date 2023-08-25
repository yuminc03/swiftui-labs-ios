//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Yumin Chu on 2023/08/24.
//

import SwiftUI

struct ScrumsView: View {
  @Binding var scrums: [DailyScrum]
  @Environment(\.scenePhase) private var scenePhase
  @State private var isPresentingNewScrumView = false
  let saveAction: () -> Void
  
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
    .onChange(of: scenePhase) { phase in
      if phase == .inactive { saveAction() }
    }
  }
}

struct ScrumsView_Previews: PreviewProvider {
  static var previews: some View {
    ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
  }
}
