//
//  LongLivingEffectsView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/25.
//

import SwiftUI

import ComposableArchitecture

extension DependencyValues {
  var screenshots: @Sendable () async -> AsyncStream<Void> {
    get { self[ScreenshotsKey.self] }
    set { self[ScreenshotsKey.self] = newValue }
  }
}

private enum ScreenshotsKey: DependencyKey {
  static let liveValue: @Sendable () async -> AsyncStream<Void> = {
    await AsyncStream(
      NotificationCenter.default.notifications(
        named: UIApplication.userDidTakeScreenshotNotification
      ).map { _ in }
    )
  }
  static let testValue: @Sendable () async -> AsyncStream<Void> = unimplemented(#"@Dependency(\.screenshots)"#, placeholder: .finished)
}

struct LonglivingEffectsCore: Reducer {
  struct State: Equatable {
    var screenShotCount = 0
  }
  
  enum Action: Equatable {
    case task
    case didTaskScreenshot
  }
  
  @Dependency(\.screenshots) var screenshots
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .task:
      return .run { send in
        for await _ in await screenshots() {
          await send(.didTaskScreenshot)
        }
      }
      
    case .didTaskScreenshot:
      state.screenShotCount += 1
      return .none
    }
  }
}

struct LongLivingEffectsView: View {
  private let store: StoreOf<LonglivingEffectsCore>
  @ObservedObject private var viewStore: ViewStoreOf<LonglivingEffectsCore>
  
  init() {
    self.store = .init(initialState: LonglivingEffectsCore.State()) {
      LonglivingEffectsCore()
    }
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Form {
      Text("A screenshot of this screen has been taken \(viewStore.screenShotCount) times.")
        .font(.headline)
      
      Section {
        NavigationLink {
          detailView
        } label: {
          Text("Navigate to another screen")
        }
      }
    }
    .navigationTitle("Long-living effects")
    .task {
      await viewStore.send(.task).finish()
    }
  }
}

struct LongLivingEffectsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LongLivingEffectsView()
    }
  }
}

extension LongLivingEffectsView {
  
  var detailView: some View {
    Text(
      """
      Take a screenshot of this screen a few times, and then go back to the previous screen to see \
      that those screenshots were not counted.
      """
    )
    .padding(.horizontal, 64)
    .navigationBarTitleDisplayMode(.inline)
  }
}
