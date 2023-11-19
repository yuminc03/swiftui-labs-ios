//
//  BindingFormTests.swift
//  TCAExampleTests
//
//  Created by Yumin Chu on 2023/11/19.
//

import XCTest

import ComposableArchitecture

@testable import TCAExample

@MainActor
final class BindingFormTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testBasics() async {
    let store = TestStore(initialState: BindingFormCore.State()) {
      BindingFormCore()
    }
    
    await store.send(.set(\.$sliderValue, 2)) {
      $0.sliderValue = 2
    }
    await store.send(.set(\.$stepCount, 1)) {
      $0.sliderValue = 1
      $0.stepCount = 1
    }
    await store.send(.set(\.$text, "Blob")) {
      $0.text = "Blob"
    }
    await store.send(.set(\.$isSwitchOn, true)) {
      $0.isSwitchOn = true
    }
    await store.send(.didTapResetButton) {
      $0 = BindingFormCore.State(text: "", isSwitchOn: false, sliderValue: 5, stepCount: 10)
    }
  }
}
