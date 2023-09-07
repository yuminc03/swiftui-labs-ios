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
    
  }
  
  enum Action: Equatable {
    
    enum Delegate: Equatable {
      case save
    }
  }
  
  @Environment(\.dismiss) var dismiss
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    return .none
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
          ForEach(City.alarmSoundsDummy) { sound in
            if sound == City.alarmSoundsDummy.last {
              NavigationLink {
                ClassicMusicListView()
              } label: {
                Text(sound.name)
              }
            } else {
              Text(sound.name)
            }
          }
        }
        Section {
          Text("실행 중단")
        }
      }
      .navigationTitle("타이머 종료 시")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("취소") {
            
          }
          .foregroundColor(.orange)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("설정") {
            
          }
          .foregroundColor(.orange)
          .fontWeight(.semibold)
        }
      }
    }
  }
}

struct EndTimerAlarmListView_Previews: PreviewProvider {
  static var previews: some View {
    EndTimerAlarmListView(store: Store(initialState: EndTimerAlarmListCore.State()) {
      EndTimerAlarmListCore()
    })
  }
}
