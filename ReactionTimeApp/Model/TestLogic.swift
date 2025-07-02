//
//  TestLogic.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

struct TestLogic {
    var timer: TestTimer = TestTimer()

    var sessionTestTotalCount: Int = 5
    var currentTestCount: Int = 0


    var recentResult: TimeInterval? {
            timer.recentReaction
    }

    var recentSessionResult: Double? = nil

    var testState: timerState {
        timer.testState
    }
    
    mutating func pressTimerButton () {
        if (timer.testState == .dormant || timer.testState == .falseStart) {
            timer.waitRandomTime()
        }
        else if (timer.testState == .waitingForUser) {
            timer.recordUserReaction()
        }
        else if (timer.testState == .waitingRandomTime) {
            timer = TestTimer()
            timer.testState = .falseStart
        }
    }


}
