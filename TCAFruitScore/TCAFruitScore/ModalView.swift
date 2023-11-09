import SwiftUI

import ComposableArchitecture

struct ModalCore: Reducer {
  struct State: Equatable {
    
  }
  
  enum Action {
    case didTapBackButton
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case increase
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapBackButton:
        return .run { send in
          await send(.delegate(.increase))
          await dismiss()
        }
        
      case .delegate:
        return .none
      }
    }
  }
}

struct ModalView: View {
  private let store: StoreOf<ModalCore>
  
  init(store: StoreOf<ModalCore>) {
    self.store = store
  }
  
  var body: some View {
    blueButton(title: "Back") {
      store.send(.didTapBackButton)
    }
  }
}

#Preview {
  ModalView(store: .init(initialState: ModalCore.State()) {
    ModalCore()
  })
}

extension ModalView {
  
  func blueButton(title: String, action: @escaping () -> Void) -> some View {
    Button(title) {
      action()
    }
    .padding(20)
    .background(Color.blue)
    .foregroundColor(.white)
    .cornerRadius(10)
  }
}
