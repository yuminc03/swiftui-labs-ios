//
//  RootView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/10.
//

import SwiftUI

struct RootView: View {
  @State var isNavigationStackCaseStudyPresented = false
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          NavigationLink {
            CounterDemoView()
          } label: {
            Text("Basics - Counter")
          }
          
          NavigationLink {
            TwoCountersView()
          } label: {
            Text("Combining reducers - Two Counters")
          }
          
          NavigationLink {
            BindingBasicsView()
          } label: {
            Text("Bindings - Binding Basics")
          }
          
          NavigationLink {
            BindingFormView()
          } label: {
            Text("Form binding - Binding form")
          }
          
          NavigationLink {
            OptionalBasicsView()
          } label: {
            Text("Optional state - Toggle counter state")
          }

          NavigationLink {
            SharedStateView()
          } label: {
            Text("Shared state - Two States")
          }
          
          NavigationLink {
            AlertAndConfirmationDialogView()
          } label: {
              Text("Alerts and Confirmation Dialogs - Increase & Decrease count")
          }
          
          NavigationLink {
            FocusDemoView()
          } label: {
            Text("Focus State - Focused TextField")
          }
          
          NavigationLink {
            AnimationsView()
          } label: {
            Text("Animation - Spring Ball")
          }
        } header: {
          Text("Getting started")
        }
        
        Section {
          NavigationLink {
            EffectBasicsView()
          } label: {
            Text("Basics - Number Fact")
          }
          
          NavigationLink {
            EffectsCancellationView()
          } label: {
            Text("Cancellation - Stepper Number Fact")
          }
          
          NavigationLink {
            LongLivingEffectsView()
          } label: {
            Text("Long-living effects - Screenshot")
          }
          
          NavigationLink {
            RefreshableView()
          } label: {
            Text("Refreshable - Refresh Counter")
          }
          
          NavigationLink {
            TimersView()
          } label: {
            Text("Timers - Rainbow Alalog Clock")
          }
          
          NavigationLink {
            WebSocketView()
          } label: {
            Text("Web socket - Send Message")
          }
        } header: {
          Text("Effects")
        }

        Section {
          Button("Stack") {
            isNavigationStackCaseStudyPresented = true
          }
          .buttonStyle(.plain)
          
          NavigationLink {
            NavigateAndLoadView()
          } label: {
            Text("Navigate and load data")
          }
        } header: {
          Text("Stack")
        }
      }
      .navigationTitle("SwiftUI TCA")
      .sheet(isPresented: $isNavigationStackCaseStudyPresented) {
        NavigationDemoView()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
