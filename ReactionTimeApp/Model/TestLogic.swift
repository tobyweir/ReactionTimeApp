//
//  TestLogic.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

struct TestLogic {
    var session: TestSession = TestSession()

    var sessionTestTotalCount: Int = 5
    var currentTestCount: Int = 0


    var recentResult: TimeInterval? {
            session.recentReaction
    }

    var recentSessionResult: Double? = nil

    var testState: timerState {
        session.testState
    }
    
    mutating func pressTimerButton () {
        if (session.testState == .dormant || session.testState == .falseStart) {
            session.waitRandomTime()
        }
        else if (session.testState == .waitingForUser) {
            session.recordUserReaction()
        }
        else if (session.testState == .waitingRandomTime) {
            session = TestSession()
            session.testState = .falseStart
        }
    }


}
