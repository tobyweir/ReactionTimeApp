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

    func getRecentSessionResults () -> [Double] {
        session.sessionResults
    }

    mutating func toggleHaveSaved () {
        haveSaved.toggle()
    }

    mutating func pressTimerButton ()  {
        let state =  session.testState
        switch (state) {
        case .waitingForUser:
            session.recordUserReaction()
            if ( session.resultCount == maxResultCount) {
                recentSessionResult =  session.sessionAverageResult
            }
        case .waitingRandomTime:
            session = TestSession(results:  session.sessionResults, resultCount:  session.resultCount)
            session.testState = .falseStart
        case .endOfSession:
            session = TestSession()
            haveSaved = false
        default:
             session.waitRandomTime()
        }
    }


}
