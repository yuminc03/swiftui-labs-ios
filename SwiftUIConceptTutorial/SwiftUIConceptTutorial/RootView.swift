//
//  RootView.swift
//  SwiftUIConceptTutorial
//
//  Created by Yumin Chu on 2023/11/05.
//

import SwiftUI

struct RootView: View {
  var body: some View {
    NavigationStack {
      Form {
        Section("🍈 SwiftUI Concepts Tutorials") {
          NavigationLink {
            ExploringSwiftUIApp()
          } label: {
            Text("Exploring SwiftUI")
          }
          NavigationLink {
            SpecifyingViewHierarchy()
          } label: {
            Text("Specifying View Hierarchy")
          }
          NavigationLink {
            RefactorTheCustomScenes()
          } label: {
            Text("Refactor the code to use custom scenes")
          }
          NavigationLink {
            MaintainAdaptableSizeInView()
          } label: {
            Text("Maintaining the adaptable sizes of built-in views")
          }
          NavigationLink {
            KeywordBubbleDefaultPadding(
              keyword: "fern-leaf lavender",
              symbol: "leaf"
            )
          } label: {
            Text("Scaling views to complement text")
          }
          NavigationLink {
            CaptionedPhoto(
              assertName: "Pink_Peony",
              captionText: "This photo is wider than it is tall."
            )
          } label: {
            Text("Layering content")
          }
          NavigationLink {
            IfElseTrainContentView()
          } label: {
            Text("Choosing the right way to hide a view")
          }
          NavigationLink {
            let event = Event(
              title: "Buy Daisies",
              date: .now,
              location: "Flower Shop",
              symbol: "gift"
            )
            EventTile(event: event)
          } label: {
            Text("Organizing and aligning content with stacks")
          }
          NavigationLink {
            TrainCarContentView()
          } label: {
            Text("Adjusting the space between views")
          }
          NavigationLink {
            RecipesSampleContentView()
          } label: {
            Text("Driving changes in your UI with state and bindings")
          }
        }
      }
      .navigationTitle("Concept Tutorial")
    }
  }
}

#Preview {
  RootView()
}
