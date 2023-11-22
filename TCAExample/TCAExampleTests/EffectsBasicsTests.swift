//
//  EffectsBasicsTests.swift
//  TCAExampleTests
//
//  Created by Yumin Chu on 2023/11/21.
//

import XCTest

import ComposableArchitecture

@testable import TCAExample

@MainActor
final class EffectsBasicsTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testCountDown() async {
    let store = TestStore(initialState: EffectBasicsCore.State()) {
      EffectBasicsCore()
    } withDependencies: {
      $0.continuousClock = ImmediateClock()
    }

    await store.send(.didTapPlusButton) {
      $0.count = 1
    }
    await store.send(.didTapMinusButton) {
      $0.count = 0
    }
  }
  
  func testNumberFact() async {
    let store = TestStore(initialState: EffectBasicsCore.State()) {
      EffectBasicsCore()
    } withDependencies: {
      $0.factClient.fetch = { "\($0) is good number Brent"}
      $0.continuousClock = ImmediateClock()
    }
        
    await store.send(.didTapPlusButton) {
      $0.count = 1
    }
    await store.send(.didTapNumberFactButton) {
      $0.isNumberFactLoading = true
    }
    await store.receive(.numberFactResponse(.success("1 is good number Brent"))) {
      $0.isNumberFactLoading = false
      $0.numberFact = "1 is good number Brent"
    }
  }
  
  func testDecrement() async {
    let store = TestStore(initialState: EffectBasicsCore.State()) {
      EffectBasicsCore()
    } withDependencies: {
      $0.continuousClock = ImmediateClock()
    }

    await store.send(.didTapMinusButton) {
      $0.count = -1
    }
    await store.receive(.decrementDelayResponse) {
      $0.count = 0
    }
  }
  
  
}
