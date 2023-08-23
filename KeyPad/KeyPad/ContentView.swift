//
//  ContentView.swift
//  KeyPad
//
//  Created by Yumin Chu on 2023/08/19.
//

import SwiftUI

import ComposableArchitecture

struct ContentView: View {
    
    private let store: StoreOf<KeyPadReducer>
    @ObservedObject private var viewStore: ViewStoreOf<KeyPadReducer>
    private let columns = [
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center)
    ]
    
    init() {
        self.store = Store(
            initialState: KeyPadReducer.State()) {
            KeyPadReducer()
                    ._printChanges()
        }
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        VStack(alignment: .center) {
            inputTextContainerView
                .contentShape(Rectangle())
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width > 0 {
                            viewStore.send(.didTapDeleteButton)
                        }
                    }
            )
            numberPadView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    var addContactMenu: some View {
        Menu {
            Button {
            } label: {
                Label(
                    "새로운 연락처 등록",
                    systemImage: "person.crop.circle"
                )
            }
            
            Button {
            } label: {
                Label(
                    "기존의 연락처에 추가",
                    systemImage: "person.crop.circle.badge.plus"
                )
            }
        } label: {
            Text("번호 추가")
                .font(.title2)
        }
    }
    
    var inputTextContainerView: some View {
        VStack(spacing: 20) {
            if viewStore.numberString.isEmpty == false {
                Text(viewStore.numberString)
                    .font(.largeTitle)
                    .animation(.none)
                addContactMenu
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height * 0.1)
        .padding(.vertical, 20)
        .animation(.spring(), value: viewStore.numberString)
    }
    
    var numberPadView: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewStore.numbers) { number in
                    if number.numberText.isEmpty {
                        clearView
                    } else if number.numberText == "call" {
                        CallGreenButton {
                            print("call button action")
                        }
                    }
                    else if number.numberText == "delete" {
                        if viewStore.numberString.isEmpty == false {
                            clearView
                            .overlay(alignment: .center) {
                                DeleteNumberView {
                                    viewStore.send(.didTapDeleteButton)
                                }
                            }
                        } else {
                            clearView
                        }
                    } else {
                        NumberView(
                            numberText: number.numberText,
                            bottomText: number.smallText
                        ) {
                            viewStore.send(.didTapNumberButton(number.numberText))
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 40)
    }
    
    var clearView: some View {
        Circle()
            .foregroundColor(.clear)
    }
}
