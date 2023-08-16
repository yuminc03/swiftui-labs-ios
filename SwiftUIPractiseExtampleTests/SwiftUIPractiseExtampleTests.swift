//
//  SwiftUIPractiseExtampleTests.swift
//  SwiftUIPractiseExtampleTests
//
//  Created by Yumin Chu on 2023/08/15.
//

import XCTest

import ComposableArchitecture
@testable import SwiftUIPractiseExtample

@MainActor
final class SwiftUIPractiseExtampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.didTapIncrementButton) {
            $0.count = 1
        }
        
        await store.send(.didTapDecrementButton) {
            $0.count = 0
        }
    }
    
    func testTimer() async {
        let clock = TestClock()
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.didTapTimerButton) {
            $0.isTimerRunning = true
        }
        
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTick) {
            $0.count = 1
        }
//        await store.receive(.timerTick, timeout: .seconds(2)) {
//            $0.count = 1
//        }
        
        await store.send(.didTapTimerButton) {
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number." }
        }
        
        await store.send(.didTapFactButton) {
            $0.isLoading = true
        }
        
        await store.receive(.factResponse("0 is a good number.")) {
            $0.isLoading = false
            $0.factString = "0 is a good number."
        }
    }
}
