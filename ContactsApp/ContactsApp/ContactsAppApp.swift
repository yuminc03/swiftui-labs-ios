//
//  ContactsAppApp.swift
//  ContactsApp
//
//  Created by Yumin Chu on 2023/08/25.
//

import SwiftUI

import ComposableArchitecture

@main
struct ContactsAppApp: App {
  var body: some Scene {
    WindowGroup {
      ContactsView(
        store: Store(
          initialState: ContactsFeature.State(
            contacts: [
              Contact(id: UUID(), name: "Eaily"),
              Contact(id: UUID(), name: "Kaila"),
              Contact(id: UUID(), name: "Crystal")
            ]
          )
        ) {
          ContactsFeature()
        }
      )
    }
  }
}
