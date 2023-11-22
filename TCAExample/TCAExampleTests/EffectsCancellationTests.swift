//
//  EffectsCancellationTests.swift
//  TCAExampleTests
//
//  Created by Yumin Chu on 2023/11/22.
//

import XCTest

import ComposableArchitecture

@testable import TCAExample

@MainActor
final class EffectsCancellationTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testTriviaSuccessfulRequest() async {
    let store = TestStore(initialState: EffectsCancellationCore.State()) {
      EffectsCancellationCore()
    } withDependencies: {
      $0.factClient.fetch = {
        "\($0) is a good number Brend"
      }
    }

    await store.send(.didChangeStepper(1)) {
      $0.count = 1
    }
    await store.send(.didChangeStepper(0)) {
      $0.count = 0
    }
    await store.send(.didTapFactButton) {
      $0.isNumberFactLoading = true
    }
    await store.receive(.factResponse(.success("0 is a good number Brend"))) {
      $0.numberFact = "0 is a good number Brend"
      $0.isNumberFactLoading = false
    }
  }
}
