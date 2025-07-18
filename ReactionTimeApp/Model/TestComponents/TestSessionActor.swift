//
//  TestSessionActor.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 18/07/2025.
//
import Foundation

actor TestSessionActor {
    var testSession: TestSession

    init(testSession: TestSession) {
        self.testSession = testSession
    }

    func setTestState (state: timerState) {
        testSession.testState = state
    }

    func setTestStartTime () {
        var startTime = Date.now
        testSession.testStartTime = startTime
    }
}
