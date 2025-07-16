//
//  TestLogic.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

actor TestLogic {
    var session: TestSession = TestSession()
    var sessionTestTotalCount: Int = 5
    var currentTestCount: Int = 0
    var recentSessionResult: Double? = nil
    var savedResult: Bool = false
    var maxResultCount: Int = 5

    func getRecentResult () async -> TimeInterval? {
        let result = await session.getRecentResult()
        return result
    }
    func getTestState () async -> timerState {
        let state = await session.getTestState()
        return state
    }

    func getHaveSaved () -> Bool {
        savedResult
    }

    func getRecentSessionResult () -> Double? {
        recentSessionResult
    }

    func toggleHaveSaved () {
        savedResult.toggle()
    }
    func pressTimerButton () {
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

//    func pressTimerButton () {
//        Task {
//            await session.pressTimerButton()
//        }
//    }


}
