//
//  AnimationTests.swift
//  TCAExampleTests
//
//  Created by Yumin Chu on 2023/11/19.
//

import XCTest
import Clocks

import ComposableArchitecture

@testable import TCAExample

@MainActor
final class AnimationTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testRainbow() async {
    let clock = TestClock()
    
    let store = TestStore(initialState: AnimationsCore.State()) {
      AnimationsCore()
    } withDependencies: {
      $0.continuousClock = clock
    }
    
    await store.send(.didTapRainbowButton)
    await store.receive(.setColor(.red)) {
      $0.circleColor = .red
    }
    await clock.advance(by: .seconds(1))
    await store.receive(.setColor(.blue)) {
      $0.circleColor = .blue
    }
    await clock.advance(by: .seconds(1))
    await store.receive(.setColor(.green)) {
      $0.circleColor = .green
    }
    await clock.advance(by: .seconds(1))
    await store.receive(.setColor(.orange)) {
      $0.circleColor = .orange
    }
    await clock.advance(by: .seconds(1))
    await store.receive(.setColor(.pink)) {
      $0.circleColor = .pink
    }
    await clock.advance(by: .seconds(1))
    await store.receive(.setColor(.purple)) {
      $0.circleColor = .purple
    }
    await clock.advance(by: .seconds(1))
    await store.receive(.setColor(.yellow)) {
      $0.circleColor = .yellow
    }
    await clock.advance(by: .seconds(1))
    await store.receive(.setColor(.black)) {
      $0.circleColor = .black
    }
    await clock.run()
  }
  
  func testReset() async {
    let clock = TestClock()
    let store = TestStore(initialState: AnimationsCore.State()) {
      AnimationsCore()
    } withDependencies: {
      $0.continuousClock = clock
    }
    
    await store.send(.didTapRainbowButton)
    await store.receive(.setColor(.red)) {
      $0.circleColor = .red
    }
    
    await clock.advance(by: .seconds(1))
    await store.receive(.setColor(.blue)) {
      $0.circleColor = .blue
    }
    
    await store.send(.didTapResetButton) {
      $0.alert = AlertState {
        TextState("Reset state?")
      } actions: {
        ButtonState(
          role: .destructive,
          action: .send(.didTapResetConfirmButton, animation: .default)
        ) {
          TextState("Reset")
        }
        ButtonState(role: .cancel) {
          TextState("Cancel")
        }
      }
    }
    await store.send(.alert(.presented(.didTapResetConfirmButton))) {
      $0 = AnimationsCore.State()
    }
    await store.finish()
  }
}
