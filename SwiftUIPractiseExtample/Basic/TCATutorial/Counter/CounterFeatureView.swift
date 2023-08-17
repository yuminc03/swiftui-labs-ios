//
//  CounterFeatureView.swift
//  TCATutorials
//
//  Created by Yumin Chu on 2023/08/12.
//

import SwiftUI

import ComposableArchitecture

struct CounterFeatureView: View {
    let store: StoreOf<CounterFeature>
    @ObservedObject var viewStore: ViewStoreOf<CounterFeature>
    
    init() {
        self.store = Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        VStack {
            Text("\(viewStore.count)")
                .common()
            HStack {
                Button("-") {
                    store.send(.didTapDecrementButton)
                }
                .common()
                
                Button("+") {
                    store.send(.didTapIncrementButton)
                }
                .common()
            }
            Button(viewStore.isTimerRunning ? "Stop" : "Start") {
                viewStore.send(.didTapTimerButton)
            }
            .common()
            
            Button("Fact") {
                store.send(.didTapFactButton)
            }
            .common()
            
            if viewStore.isLoading {
                ProgressView()
            } else if let fact = viewStore.factString {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

struct CounterFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        CounterFeatureView()
    }
}
