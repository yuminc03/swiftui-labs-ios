//
//  RootView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/10.
//

import SwiftUI

struct RootView: View {
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
        } header: {
          Text("Effects")
        }

      }
      .navigationTitle("SwiftUI TCA")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
