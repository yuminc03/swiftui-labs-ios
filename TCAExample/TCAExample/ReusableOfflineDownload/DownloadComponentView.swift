//
//  DownloadComponentView.swift
//  TCAExample
//
//  Created by Yumin Chu on 2023/10/27.
//

import SwiftUI

import ComposableArchitecture

struct DownloadComponent: Reducer {
  struct State: Equatable {
    @PresentationState var alert: AlertState<Action.Alert>?
    let id: AnyHashable
    var mode: Mode
    let url: URL
  }
  
  enum Action {
    case alert(PresentationAction<Alert>)
    case didTapDownloadButton
    case downloadClient(TaskResult<DownloadClient.Event>)
    
    enum Alert: Equatable {
      case didTapDeleteButton
      case didTapStopButton
    }
  }
  
  @Dependency(\.downloadClient) var downloadClient
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .alert(.presented(.didTapDeleteButton)):
        return .none
        
      case .alert(.presented(.didTapStopButton)):
        return .none
        
      case .alert:
        return .none
        
      case .didTapDownloadButton:
        switch state.mode {
        case .downloaded:
          state.alert = deleteAlert
          return .none
          
        case .downloading:
          state.alert = stopAlert
          return .none
          
        case .notDownloaded:
          state.mode = .startingToDownload
          
          return .run { [state] send in
            for try await event in downloadClient.download(state.url) {
              await send(.downloadClient(.success(event)), animation: .default)
            }
          } catch: { error, send in
            await send(.downloadClient(.failure(error)), animation: .default)
          }
          .cancellable(id: state.id)
          
        case .startingToDownload:
          state.alert = stopAlert
          return .none
        }
        
      case .downloadClient(.success(.response)):
        state.mode = .downloaded
        state.alert = nil
        return .none
        
      case let .downloadClient(.success(.updateProgress(progress))):
        state.mode = .downloading(progress: progress)
        return .none
        
      case .downloadClient(.failure):
        state.mode = .notDownloaded
        state.alert = nil
        return .none
      }
    }
    .ifLet(\.$alert, action: /Action.alert)
  }
  
  private var deleteAlert: AlertState<Action.Alert> {
    AlertState {
      TextState("Do you want to delete this map from your offline storage?")
    } actions: {
      ButtonState(role: .destructive, action: .send(.didTapDeleteButton, animation: .default)) {
        TextState("Delete")
      }
      nevermindButton
    }
  }
  
  private var stopAlert: AlertState<Action.Alert> {
    AlertState {
      TextState("Do you want to stop downloading this map?")
    } actions: {
      ButtonState(role: .destructive, action: .send(.didTapStopButton, animation: .default)) {
        TextState("Stop")
      }
      nevermindButton
    }
  }
  
  private var nevermindButton: ButtonState<Action.Alert> {
    ButtonState(role: .cancel) {
      TextState("Nevermind")
    }
  }
}

// MARK: - Mode

enum Mode: Equatable {
  case downloaded
  case downloading(progress: Double)
  case notDownloaded
  case startingToDownload
  
  var progress: Double {
    if case let .downloading(progress) = self {
      return progress
    }
    
    return 0
  }
  
  var isDownloading: Bool {
    switch self {
    case .downloaded, .notDownloaded:
      return false
      
    case .downloading, .startingToDownload:
      return true
    }
  }
}

struct DownloadComponentView: View {
  private let store: StoreOf<DownloadComponent>
  @ObservedObject private var viewStore: ViewStoreOf<DownloadComponent>
  
  init(store: StoreOf<DownloadComponent>) {
    self.store = store
    self.viewStore = .init(store, observe: { $0 })
  }
  
  var body: some View {
    Button {
      store.send(.didTapDownloadButton)
    } label: {
      if viewStore.mode == .downloaded {
        Image(systemName: "checkmark.circle")
          .tint(.accentColor)
      } else if viewStore.mode.progress > 0 {
        ZStack {
          CircularProgressView(value: viewStore.mode.progress)
            .frame(width: 16, height: 16)
          Rectangle()
            .frame(width: 6, height: 6)
        }
      } else if viewStore.mode == .notDownloaded {
        Image(systemName: "icloud.and.arrow.down")
        
      } else if viewStore.mode == .startingToDownload {
        ZStack {
          ProgressView()
          Rectangle()
            .frame(width: 6, height: 6)
        }
      }
    }
    .foregroundColor(.primary)
    .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
  }
}

struct DownloadComponentView_Previews: PreviewProvider {
  static var previews: some View {
    CitiesView_Previews.previews
  }
}
