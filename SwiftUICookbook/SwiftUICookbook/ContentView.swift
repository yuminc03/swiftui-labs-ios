//
//  ContentView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/08/31.
//

import SwiftUI

struct ContentView: View {
//  @State private var launch = false
  @State private var showMainApp = false
  
  var body: some View {
//    VStack {
//      RocketShape()
//        .fill(Color.red)
//        .frame(width: 100, height: 200)
//        .offset(y: launch ? -300 : 0)
//        .animation(.easeInOut(duration: 2), value: launch)
//
//      Button("Launch") {
//        launch.toggle()
//      }
//      .padding()
//    }
    
//    if showMainApp {
//      Text("Selcome to CosmoJourney!")
//        .multilineTextAlignment(.center)
//        .font(.largeTitle)
//    } else {
//      VStack {
//        TabView {
//          OnboardingView(
//            title: "The Final Frontier",
//            image: "globe",
//            description: "Explore the universe from the comfort of your spaceship!"
//          )
//          OnboardingView(
//            title: "Meet Alien Friends",
//            image: "person.3.fill",
//            description: "Make intergalactic friendships with beings from other planets!"
//          )
//          OnboardingView(
//            title: "Astronaut Life",
//            image: "suit.fill",
//            description: "Live the astronaut lifestyle with zero gravity workouts!"
//          )
//        }
//        .tabViewStyle(.page)
//
//        Spacer()
//
//        Button("Get Started") {
//          showMainApp.toggle()
//        }
//        .padding()
//        .font(.title3)
//        .background(Color.blue)
//        .foregroundColor(.white)
//        .cornerRadius(10)
//        .padding(.bottom)
//      }
//    }
    
    VStack {
      Text("Pet Store Monthly Sales")
        .font(.headline)
      LineChartView()
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
