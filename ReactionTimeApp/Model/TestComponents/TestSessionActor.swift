//
//  TestSessionActor.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 17/07/2025.
//
import Foundation

actor TestSessionActor {
    var testStartTime: Date?
    var randomTimeInterval: Double
    var testState: timerState

    init (state: timerState, randomTime: Double) {
        testState = state
        randomTimeInterval = randomTime
        testStartTime = nil
    }

    func setTestStartTime (date: Date) {
        testStartTime = date
    }

    func getTestStartTime () -> Date? {
        testStartTime
    }

    func getRandomWaitTime () -> Double {
        randomTimeInterval
    }

    func setTestState (state: timerState) {
        testState = state
    }

    func getTestState () -> timerState {
        testState
    }

}
