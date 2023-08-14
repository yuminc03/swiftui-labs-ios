//
//  KeyPadView.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/08/14.
//

import SwiftUI

import ComposableArchitecture

struct KeyPadView: View {
    
    let store: StoreOf<KeyPadReducer>
    @ObservedObject var viewStore: ViewStoreOf<KeyPadReducer>
    
    init() {
        self.store = Store(
            initialState: KeyPadReducer.State()) {
            KeyPadReducer()
        }
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(spacing: 20) {
                Text(viewStore.numberString)
                    .font(.largeTitle)
                if viewStore.numberString.isEmpty == false {
                    Button {
                        
                    } label: {
                        Text("번호 추가")
                            .font(.title2)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.25)
            VStack {
                HStack(spacing: 20) {
                    NumberView(numberText: "1", bottomText: "")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("1"))
                        }
                    NumberView(numberText: "2", bottomText: "A B C")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("2"))
                        }
                    NumberView(numberText: "3", bottomText: "D E F")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("3"))
                        }
                }
                .padding(.vertical, 5)
                HStack(spacing: 20) {
                    NumberView(numberText: "4", bottomText: "G H I")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("4"))
                        }
                    NumberView(numberText: "5", bottomText: "J K L")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("5"))
                        }
                    NumberView(numberText: "6", bottomText: "M N O")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("6"))
                        }
                }
                .padding(.vertical, 5)
                HStack(spacing: 20) {
                    NumberView(numberText: "7", bottomText: "P Q R S")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("7"))
                        }
                    NumberView(numberText: "8", bottomText: "T U V")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("8"))
                        }
                    NumberView(numberText: "9", bottomText: "W X Y Z")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("9"))
                        }
                }
                .padding(.vertical, 5)
                HStack(spacing: 20) {
                    SpecialCharacterView(character: "﹡")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("﹡"))
                        }
                    NumberView(numberText: "0", bottomText: "+")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("0"))
                        }
                    SpecialCharacterView(character: "#")
                        .onTapGesture {
                            viewStore.send(.didTapNumberButton("#"))
                        }
                }
                .padding(.vertical, 5)
                HStack(spacing: 20) {
                    ZStack {
                        Image(systemName: "phone.circle.fill")
                            .resizable()
                            .frame(
                                width: (UIScreen.main.bounds.width - 120) / 3,
                                height: (UIScreen.main.bounds.width - 120) / 3
                            )
                            .symbolRenderingMode(.multicolor)
                        
                        HStack {
                            Spacer()
                            Image(systemName: "delete.left.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 30)
                                .symbolRenderingMode(.hierarchical)
                                .padding(.horizontal, (UIScreen.main.bounds.width - 120) / 5)
                                .onTapGesture {
                                    viewStore.send(.didTapDeleteButton)
                                }
                        }
                    }
                }
                .padding(.vertical, 5)
            }
        }
    }
}

struct KeyPadView_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadView()
    }
}
