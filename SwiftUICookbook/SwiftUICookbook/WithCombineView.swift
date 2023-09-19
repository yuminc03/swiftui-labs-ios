//
//  WithCombineView.swift
//  SwiftUICookbook
//
//  Created by Yumin Chu on 2023/09/15.
//

import Combine
import SwiftUI

class JokeFetcher: ObservableObject {
  @Published var joke: String = ""
  private var cancelBag: AnyCancellable?
  private let jokes = [
    "Why don't scientists trust atoms? Because they make up everything!",
    "Why did the bicycle fall over? Because it was two tired!",
    "Why don't some animals play cards? Because they are afraid of cheetahs!",
    "Why did the scarecrow win an award? Because he was outstanding in his field!"
  ]
  
  func fetchJoke() {
    if let randomJoke = jokes.randomElement() {
      joke = randomJoke
    }
  }
  
  deinit {
    cancelBag?.cancel()
  }
}

struct WithCombineView: View {
  @StateObject private var jokeFetcher = JokeFetcher()
  
  var body: some View {
    VStack {
      Text(jokeFetcher.joke)
        .padding()
      Button("Fetch Joke") {
        jokeFetcher.fetchJoke()
      }
    }
    .onAppear {
      jokeFetcher.fetchJoke()
    }
  }
}

struct WithCombineView_Previews: PreviewProvider {
  static var previews: some View {
    WithCombineView()
  }
}
