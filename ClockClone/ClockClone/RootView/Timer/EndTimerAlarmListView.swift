//
//  EndTimerAlarmListView.swift
//  ClockClone
//
//  Created by Yumin Chu on 2023/09/06.
//

import SwiftUI

import ComposableArchitecture

struct EndTimerAlarmListCore: Reducer {
  struct State: Equatable {
    var sounds = AlarmSound.alarmSoundsDummy
    var clickedSound: AlarmSound?
  }
  
  enum Action {
    case toggleIsSelected
    case didTapCancelButton
    case didTapSetButton
    case didTapRow(AlarmSound)
    case delegate(Delegate)
    
    enum Delegate: Equatable {
      case save(AlarmSound)
    }
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .toggleIsSelected:
        state.sounds[26].isSelected.toggle()
        return .none
        
      case .didTapCancelButton:
        return .run { _ in
          await dismiss()
        }
        
      case .didTapSetButton:
        guard let sound = state.clickedSound else { return .none }
        return .run { send in
          await send(.delegate(.save(sound)))
          await dismiss()
        }
        
      case let .didTapRow(sound):
        state.sounds = AlarmSound.alarmSoundsDummy
        state.sounds[state.sounds.index(id: sound.id) ?? 0].isSelected = true
        state.clickedSound = AlarmSound(name: sound.name, isSelected: true)
        return .none
        
      case .delegate:
        return .none
      }
    }
  }
}

struct EndTimerAlarmListView: View {
  private let store: StoreOf<EndTimerAlarmListCore>
  @ObservedObject var viewStore: ViewStoreOf<EndTimerAlarmListCore>
  
  init(store: StoreOf<EndTimerAlarmListCore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
  
  var body: some View {
    NavigationStack {
      List {
        Section {
          ForEach(viewStore.sounds) { sound in
            if sound == viewStore.sounds.last {
              NavigationLink {
                ClassicMusicListView()
              } label: {
                checkmarkRow(name: sound.name, isSelected: sound.isSelected)
              }
            } else {
              checkmarkRow(name: sound.name, isSelected: sound.isSelected)
                .onTapGesture {
                  store.send(.didTapRow(sound))
                }
            }
          }
        }
        Section {
          Text("실행 중단")
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            store.send(.didTapSetButton)
          } label: {
            Text("설정")
              .foregroundColor(.orange)
              .fontWeight(.semibold)
          }
        }
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            store.send(.didTapCancelButton)
          } label: {
            Text("취소")
              .foregroundColor(.orange)
          }
        }
      }
      .navigationTitle("타이머 종료 시")
      .navigationBarTitleDisplayMode(.inline)
    }
    .onAppear {
      store.send(.toggleIsSelected)
    }
  }
}

struct EndTimerAlarmListView_Previews: PreviewProvider {
  static var previews: some View {
    EndTimerAlarmListView(store: Store(initialState: EndTimerAlarmListCore.State()) {
      EndTimerAlarmListCore()
        ._printChanges()
    })
    .previewLayout(.sizeThatFits)
  }
}

extension View {
  
  func checkmarkRow(name: String, isSelected: Bool) -> some View {
    HStack {
      Label {
        Text(name)
      } icon: {
        Image(systemName: "checkmark")
          .foregroundColor(isSelected ? .orange : .clear)
          .fontWeight(.bold)
      }
      Spacer()
    }
    .contentShape(Rectangle())
  }
}
