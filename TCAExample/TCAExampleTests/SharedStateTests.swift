//
//  SharedStateTests.swift
//  TCAExampleTests
//
//  Created by Yumin Chu on 2023/11/20.
//

import XCTest

import ComposableArchitecture

@testable import TCAExample

@MainActor
final class SharedStateTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testTabRestoredOnReset() async {
    let store = TestStore(initialState: SharedStateCore.State()) {
      SharedStateCore()
    }

    await store.send(.selectTab(.profile)) {
      $0.currentTab = .profile
      $0.profile = SharedStateCore.Profile.State(
        currentTab: .profile, count: 0, maxCount: 0, minCount: 0, numberOfCounts: 0
      )
    }
    await store.send(.profile(.reset)) {
      $0.currentTab = .counter
      $0.profile = SharedStateCore.Profile.State(
        currentTab: .counter, count: 0, maxCount: 0, minCount: 0, numberOfCounts: 0
      )
    }
  }
  
  func testTabSelection() async {
    let store = TestStore(initialState: SharedStateCore.State()) {
      SharedStateCore()
    }
    
    await store.send(.selectTab(.profile)) {
      $0.currentTab = .profile
      $0.profile = SharedStateCore.Profile.State(
        currentTab: .profile, count: 0, maxCount: 0, minCount: 0, numberOfCounts: 0
      )
    }
    await store.send(.selectTab(.counter)) {
      $0.currentTab = .counter
      $0.profile = SharedStateCore.Profile.State(
        currentTab: .counter, count: 0, maxCount: 0, minCount: 0, numberOfCounts: 0
      )
    }
  }
  
  func testSharedCounts() async {
    let store = TestStore(initialState: SharedStateCore.State()) {
      SharedStateCore()
    }
    
    await store.send(.counter(.didTapIncrementButton)) {
      $0.counter.count = 1
      $0.counter.maxCount = 1
      $0.counter.numberOfCounts = 1
    }
    await store.send(.counter(.didTapDecrementButton)) {
      $0.counter.count = 0
      $0.counter.numberOfCounts = 2
    }
    await store.send(.counter(.didTapDecrementButton)) {
      $0.counter.count = -1
      $0.counter.minCount = -1
      $0.counter.numberOfCounts = 3
    }
  }
  
  func testIsPrimeWhenPrime() async {
    let store = TestStore(initialState: SharedStateCore.Counter.State(
      count: 3, maxCount: 0, minCount: 0, numberOfCounts: 0, alert: nil
    )) {
      SharedStateCore.Counter()
    }
    
    await store.send(.didTapIsPrimeButton) {
      $0.alert = AlertState {
        TextState("👍 The number 3 is prime!")
      }
    }
    await store.send(.alert(.dismiss)) {
      $0.alert = nil
    }
  }
  
  
}
