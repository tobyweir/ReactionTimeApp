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
    var recentSessionResult: Double? = nil
    var haveSaved: Bool = false
    var maxResultCount: Int = 5

    var testState: timerState {
        session.testState
    }

    var recentResult: TimeInterval? {
        session.recentReaction
    }

    func getRecentSessionResult () -> Double? {
        recentSessionResult
    }

    mutating func toggleHaveSaved () {
        haveSaved.toggle()
    }

    mutating func pressTimerButton ()  {
        let state =  session.getTestState()
        switch (state) {
        case .waitingForUser:
            session.recordUserReaction()
            if ( session.getResultCount() == maxResultCount) {
                recentSessionResult =  session.getSessionAverage()
            }
        case .waitingRandomTime:
            session = TestSession(results:  session.getSessionResults(), resultCount:  session.getResultCount())
            session.setTestState(state: .falseStart)
        case .endOfSession:
            session = TestSession()
            haveSaved = false
        default:
             session.waitRandomTime()
        }
    }


}
