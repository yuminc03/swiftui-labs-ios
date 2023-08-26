//
//  ContentView.swift
//  Payco
//
//  Created by Yumin Chu on 2023/08/26.
//

import SwiftUI

import ComposableArchitecture

struct ContentCore: Reducer {
  struct State: Equatable {
    var selectedIndex = 0
    let menu1 = PointMenuItem.dummy
  }
  
  enum Action {
    case didTapTabItem
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapTabItem:
        return .none
      }
    }
  }
}

struct ContentView: View {
  private let columns = [
    GridItem(.flexible(), spacing: 20, alignment: .center),
    GridItem(.flexible(), spacing: 20, alignment: .center),
    GridItem(.flexible(), spacing: 20, alignment: .center),
    GridItem(.flexible(), spacing: 20, alignment: .center)
  ]
  private let pointpaymentBenefitColumns = [
    GridItem(.flexible(), spacing: 10, alignment: .center)
  ]
  private let store: StoreOf<ContentCore>
  @ObservedObject private var viewStore: ViewStoreOf<ContentCore>
  
  init() {
    self.store = .init(initialState: .init()) {
      ContentCore()
    }
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationView {
      List {
        Section {
          HStack(spacing: 10) {
            title
            Spacer()
            TopRightButton(imageName: "ticket")
            TopRightButton(imageName: "bell")
            TopRightButton(imageName: "person")
          }
        }
        .listRowSeparator(.hidden)

        Section {
          section1
        }
        .listRowSeparator(.hidden)
        
        Section {
          section2
        }
        .listRowSeparator(.hidden)
        
        Section {
          section1
        }
        .listRowSeparator(.hidden)
        
        Section {
          section4
        }
        .listRowSeparator(.hidden)
        
        Section {
          
        }
        .listRowSeparator(.hidden)
        
        Section {
          
        }
        .listRowSeparator(.hidden)
        
        Section {
          
        }
        .listRowSeparator(.hidden)
        
        Section {
          
        }
        .listRowSeparator(.hidden)
        
        Section {
          
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension ContentView {
  
  var title: some View {
    Text("포인트")
      .font(.title)
      .bold()
  }
  
  var section1: some View {
    RoundedRectangle(cornerRadius: 20)
      .frame(height: 150)
      .foregroundColor(.gray)
  }
  
  var section2: some View {
    LazyVGrid(columns: columns, spacing: 20) {
      ForEach(viewStore.menu1) { item in
        VStack(spacing: 10) {
          Image(systemName: item.imageName)
            .font(.largeTitle)
            .foregroundColor(item.iconColor)
          Text(item.title)
            .font(.caption)
        }
      }
    }
  }
  
  var section4: some View {
    RoundedRectangle(cornerRadius: 20)
      .foregroundColor(Color("gray_EAEAEA"))
      .frame(height: 500)
      .overlay {
        VStack(spacing: 20) {
          HStack {
            Text("8월 포인트 결제 혜택")
              .font(.title3)
              .bold()
            Spacer()
          }
          .padding(.leading, 20)
          
        }
      }
  }
  
  var pointpaymentBenefitMenu: some View {
    LazyHGrid(rows: pointpaymentBenefitColumns, spacing: 20) {
      
    }
  }
}
