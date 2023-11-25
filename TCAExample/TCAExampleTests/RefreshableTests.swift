//
//  RefreshableTests.swift
//  TCAExampleTests
//
//  Created by Yumin Chu on 2023/11/23.
//

import XCTest

import ComposableArchitecture

@testable import TCAExample

@MainActor
final class RefreshableTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testHappyPath() async {
    let store = TestStore(initialState: RefreshableCore.State()) {
      RefreshableCore()
    } withDependencies: {
      $0.factClient.fetch = {
        "\($0) is a good number."
      }
      $0.continuousClock = ImmediateClock()
    }

    await store.send(.didTapPlusButton) {
      $0.count = 1
    }
    await store.send(.refresh)
    await store.receive(.factResponse(.success("1 is a good number."))) {
      $0.factString = "1 is a good number."
    }
  }
}
