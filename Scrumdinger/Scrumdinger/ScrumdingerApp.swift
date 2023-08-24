//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Yumin Chu on 2023/08/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
  @State private var scrums = DailyScrum.sampleData
  
    var body: some Scene {
        WindowGroup {
          ScrumsView(scrums: $scrums)
        }
    }
}
