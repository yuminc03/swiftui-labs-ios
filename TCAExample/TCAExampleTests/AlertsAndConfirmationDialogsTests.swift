//
//  AlertsAndConfirmationDialogsTests.swift
//  TCAExampleTests
//
//  Created by Yumin Chu on 2023/11/14.
//

import XCTest

import ComposableArchitecture

@testable import TCAExample

@MainActor
final class AlertsAndConfirmationDialogsTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testAlert() async {
    let store = TestStore(initialState: AlertAndConfirmationDialogCore.State()) {
      AlertAndConfirmationDialogCore()
    }
    
    await store.send(.didTapAlertButton) {
      $0.alert = AlertState {
        TextState("Alert")
      } actions: {
        ButtonState(role: .cancel) {
          TextState("Cancel")
        }
        ButtonState(action: .didTapIncreaseButton) {
          TextState("Increment")
        }
      } message: {
        TextState("This is an alert.🙂")
      }
    }
    
    await store.send(.alert(.presented(.didTapIncreaseButton))) {
      $0.alert = AlertState {
        TextState("Incremented!🎉")
      }
      $0.count = 1
    }
    
    await store.send(.alert(.dismiss)) {
      $0.alert = nil
    }
  }
}
