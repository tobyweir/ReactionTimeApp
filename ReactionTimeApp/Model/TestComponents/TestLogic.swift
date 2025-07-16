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
    var savedResult: Bool = false
    var maxResultCount: Int = 5
    var testState: timerState {
        Task {
            let state = await session.getTestState()
            return state
        }
    }

    var recentResult: TimeInterval? {
            session.recentReaction
    }

//    mutating func pressTimerButton () {
//        if (session.testState == .dormant || session.testState == .falseStart) {
//            session.waitRandomTime()
//        }
//        else if (session.testState == .endOfSession) {
//            session = TestSession()
//            savedResult = false
//        }
//        else if (session.testState == .waitingForUser) {
//            session.recordUserReaction()
//            if (resultCount == session.maxResultCount) {
//                recentSessionResult = session.sessionAverageResult
//            }
//        }
//        else if (session.testState == .waitingRandomTime) {
//            //recreate session so we can avoid waiting for timer to end
//            session = TestSession(results: session.sessionResults, resultCount: session.resultCount)
//            session.testState = .falseStart
//        }
//    }

    mutating func pressTimerButton () {
        Task {
            let state = await session.getTestState()
            switch (state) {
            case .waitingForUser:
                await session.recordUserReaction()
                if (await session.getResultCount() == maxResultCount) {
                    recentSessionResult = await session.getSessionAverage()
                }
            case .waitingRandomTime:
                session = TestSession(results: await session.getSessionResults(), resultCount: await session.getResultCount())
            case .endOfSession:
                session = TestSession()
                savedResult = false
            default:
                await session.waitRandomTime()
            }
        }
    }


}
