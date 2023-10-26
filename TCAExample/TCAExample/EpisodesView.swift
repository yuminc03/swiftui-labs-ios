//
//  EpisodesView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/26.
//

import SwiftUI

import ComposableArchitecture

struct EpisodesCore: Reducer {
  struct State: Equatable {
    var episodes: IdentifiedArrayOf<EpisodeCore.State> = []
  }
  
  enum Action {
    case episode(id: EpisodeCore.State.ID, action: EpisodeCore.Action)
  }
  
  let favorite: @Sendable (UUID, Bool) async throws -> Bool
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      return .none
    }
    .forEach(\.episodes, action: /Action.episode) {
      EpisodeCore(favorite: favorite)
    }
  }
}

struct EpisodesView: View {
  private let store: StoreOf<EpisodesCore>
  
  init() {
    self.store = .init(initialState: EpisodesCore.State()) {
      EpisodesCore()
    }
  }
  
  var body: some View {
    Form {
      ForEach(store.scope(
        state: \.episodes,
        action: { .episode(id: $0, action: $1)}
      ))
    }
    .navigationTitle("Favoriting")
  }
}

struct EpisodesView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EpisodesView()
    }
  }
}

// MARK: - Episode

struct EpisodeCore: Reducer {
  struct State: Equatable {
    var alert: AlertState<FavoritingAction.Alert>?
    let id: UUID
    var isFavorite: Bool
    let title: String
    
    var favorite: FavoritingState<ID> {
      get { .init(alert: alert, id: id, isFavorite: isFavorite) }
      set { (alert, isFavorite) = (newValue.alert, newValue.isFavorite) }
    }
  }
  
  enum Action {
    case favorite(FavoritingAction)
  }
  
  let favorite: @Sendable (UUID, Bool) async throws -> Bool
  
  var body: some ReducerOf<Self> {
    Scope(state: \.favorite, action: /Action.favorite) {
      Favoriting(favorite: favorite)
    }
  }
}

struct EpisodeView: View {
  private let store: StoreOf<EpisodeCore>
  @ObservedObject private var viewStore: ViewStoreOf<EpisodeCore>
  
  init(store: StoreOf<EpisodeCore>) {
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(viewStore.title)
      Spacer()
      
    }
  }
}

// MARK: - FavoritingState

struct FavoritingState<ID: Hashable & Sendable>: Equatable {
  @PresentationState var alert: AlertState<FavoritingAction.Alert>?
  let id: ID
  var isFavorite: Bool
}

enum FavoritingAction: Equatable {
  case alert(PresentationAction<Alert>)
  case didTapButton
  case response(TaskResult<Bool>)
  
  enum Alert: Equatable { }
}

struct Favoriting<ID: Hashable & Sendable>: Reducer {
  let favorite: @Sendable (ID, Bool) async throws -> Bool
  
  private struct CancelID: Hashable {
    let id: AnyHashable
  }
  
  func reduce(into state: inout FavoritingState<ID>, action: FavoritingAction) -> Effect<FavoritingAction> {
    switch action {
    case .alert(.dismiss):
      state.alert = nil
      state.isFavorite.toggle()
      return .none
      
    case .didTapButton:
      state.isFavorite.toggle()
      return .run { [state] send in
        await send(.response(
          TaskResult { try await favorite(state.id, state.isFavorite) }
        ))
      }
      .cancellable(id: CancelID(id: state.id), cancelInFlight: true)
      
    case let .response(.success(isFavorite)):
      state.isFavorite = isFavorite
      return .none
      
    case let .response(.failure(error)):
      state.alert = AlertState {
        TextState(error.localizedDescription)
      }
      return .none
    }
  }
}

// MARK: - FavoriteButton

struct FavoriteButton<ID: Hashable & Sendable>: View {
  private let store: Store<FavoritingState<ID>, FavoritingAction>
  @ObservedObject private var viewStore: ViewStore<FavoritingState<ID>, FavoritingAction>
  
  init(store: Store<FavoritingState<ID>, FavoritingAction>) {
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Button {
      store.send(.didTapButton)
    } label: {
      Image(systemName: "heart")
        .symbolVariant(viewStore.isFavorite ? .fill : .none)
    }
    .alert(store: store.scope(
      state: \.$alert, action: { .alert($0) }
    ))
  }
}

struct FavoriteError: LocalizedError, Equatable {
  var errorDescription: String? {
    return "Favoriting failed."
  }
}

@Sendable func favorite<ID>(id: ID, isFavorite: Bool) async throws -> Bool {
  try await Task.sleep(for: .seconds(1))
  if .random(in 0 ... 1) > 0.25 {
    return isFavorite
  } else {
    return FavoriteError()
  }
}

extension IdentifiedArray where ID == Equatable.State.ID, Element == EpisodeCore {
  
}
