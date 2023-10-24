//
//  AnimationsView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/24.
//

import SwiftUI

import ComposableArchitecture

private let readMe = """
  This screen demonstrates how changes to application state can drive animations. Because the \
  `Store` processes actions sent to it synchronously you can typically perform animations \
  in the Composable Architecture just as you would in regular SwiftUI.

  To animate the changes made to state when an action is sent to the store you can pass along an \
  explicit animation, as well, or you can call `viewStore.send` in a `withAnimation` block.

  To animate changes made to state through a binding, use the `.animation` method on `Binding`.

  To animate asynchronous changes made to state via effects, use `Effect.run` style of effects \
  which allows you to send actions with animations.

  Try it out by tapping or dragging anywhere on the screen to move the dot, and by flipping the \
  toggle at the bottom of the screen.
  """
struct AnimationsCore: Reducer {
  struct State: Equatable {
    var circleCenter: CGPoint?
    var circleColor = Color.black
    var isCircleScaled = false
  }
  
  enum Action {
    case tapGesture(CGPoint)
    
    enum Alert: Equatable, Sendable {
      case didTapResetConfirmButton
    }
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .tapGesture(point):
        return .none
      }
    }
  }
}
struct AnimationsView: View {
  private let store: StoreOf<AnimationsCore>
  @ObservedObject private var viewStore: ViewStoreOf<AnimationsCore>
  
  init() {
    self.store = .init(initialState: AnimationsCore.State()) {
      AnimationsCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(readMe)
        .font(.body)
        .padding()
        .gesture(
          DragGesture(
            minimumDistance: 0
          ).onChanged { gesture in
            viewStore.send(
              .tapGesture(gesture.location),
              animation: .interactiveSpring(
                response: 0.25, dampingFraction: 0.1
              )
            )
          }
        )
        .overlay {
          GeometryReader { proxy in
            Circle()
              .fill(viewStore.circleColor)
              .colorInvert()
              .blendMode(.difference)
              .frame(width: 50, height: 50)
              .scaleEffect(viewStore.isCircleScaled ? 2 : 1)
              .position(
                x: viewStore.circleCenter?.x ?? proxy.size.width,
                y: viewStore.circleCenter?.y ?? proxy.size.height
              )
//              .scaleEffect(viewStore.circleCenter == nil 0 : 44)
          }
        }
    }
  }
}

struct AnimationsView_Previews: PreviewProvider {
  static var previews: some View {
    AnimationsView()
  }
}
