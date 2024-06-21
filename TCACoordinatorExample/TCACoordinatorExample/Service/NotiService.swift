//
//  NotiService.swift
//  TCACoordinatorExample
//
//  Created by LS-NOTE-00106 on 6/20/24.
//

import Foundation
import Combine

enum NotiKey: String {
  case showTab
  case hideTab
  
  var name: Notification.Name {
    return .init(self.rawValue)
  }
}

enum NotiService {
  static func publisher(
    name: NotiKey,
    on scheduler: some Scheduler = DispatchQueue.main
  ) -> AnyPublisher<[AnyHashable: Any]?, Never> {
    NotificationCenter.default.publisher(for: name.name)
      .receive(on: scheduler)
      .map(\.userInfo)
      .eraseToAnyPublisher()
  }
  
  static func post(name: NotiKey, userInfo: [AnyHashable: Any]? = nil) {
    NotificationCenter.default.post(name: name.name, object: nil, userInfo: userInfo)
  }
}
