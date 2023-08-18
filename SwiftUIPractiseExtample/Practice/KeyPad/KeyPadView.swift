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
                    ._printChanges()
        }
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        TabView(selection: viewStore.binding(
            get: \.selectedTab,
            send: KeyPadReducer.Action.didTapTabItem
        )) {
            Text("First")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("즐겨찾기")
                }
                .tag(0)
            Text("Second")
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("최근 통화")
                }
                .tag(1)
            Text("Third")
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("연락처")
                }
                .tag(2)
            VStack(alignment: .center) {
                VStack(spacing: 20) {
                    if viewStore.numberString.isEmpty == false {
                        Text(viewStore.numberString)
                            .font(.largeTitle)
                        addContactMenu
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            viewStore.send(.didTapDeleteButton)
                        }
                )
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height * 0.1)
                .padding(.vertical, 20)
                .animation(.spring())
                
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
                        SpecialCharacterView(character: "﹡", backgroundColor: Color("gray_D8D8D8"))
                            .onTapGesture {
                                viewStore.send(.didTapNumberButton("﹡"))
                            }
                        NumberView(numberText: "0", bottomText: "+")
                            .onTapGesture {
                                viewStore.send(.didTapNumberButton("0"))
                            }
                        SpecialCharacterView(character: "#", backgroundColor: Color("gray_D8D8D8"))
                            .onTapGesture {
                                viewStore.send(.didTapNumberButton("#"))
                            }
                    }
                    .padding(.vertical, 5)
                    HStack(spacing: 20) {
                        SpecialCharacterView(character: "", backgroundColor: .clear)
                        CallGreenView()
                        if viewStore.numberString.isEmpty == false {
                            SpecialCharacterView(character: "", backgroundColor: .clear)
                                .overlay(alignment: .center) {
                                    DeleteNumberView()
                                        .onTapGesture {
                                            viewStore.send(.didTapDeleteButton)
                                        }
                                }
                        } else {
                            SpecialCharacterView(character: "", backgroundColor: .clear)
                        }
                    }
                    .padding(.vertical, 5)
                    .animation(.spring())
                }
            }
            .padding(.bottom, 10)
            .tabItem {
                Image(systemName: "circle.grid.3x3.fill")
                Text("키패드")
            }
            .tag(3)
            Text("Fifth")
                .tabItem {
                    Image(systemName: "recordingtape")
                    Text("음성 사서함")
                }
                .tag(4)
        }
    }
}

struct KeyPadView_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadView()
    }
}

extension KeyPadView {
    
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
}
