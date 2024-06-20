//
//  StateManager.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import Foundation
import Combine

final class StateManager: ObservableObject {
  @Published var isTabBarPresented = true
  private var cancelBag = Set<AnyCancellable>()
  
  init() {
    NotiService.publisher(name: .showTab)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.isTabBarPresented = true
      }
      .store(in: &cancelBag)
    
    NotiService.publisher(name: .hideTab)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.isTabBarPresented = false
      }
      .store(in: &cancelBag)
  }
}
