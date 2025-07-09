//
//  Timer.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

@Observable class TestSession {
    var testState: timerState = .dormant
    var randomTimeInterval: Double = 0
    var testStartTime: Date = Date.now
    var recentReaction: TimeInterval? = nil
    var minRandomWaitTime: Double = 0.4
    var maxRandomWaitTime: Double = 7.0
    var maxResultCount: Int = 5
    var resultCount: Int = 0
    var sessionResults: [TimeInterval] = []
    var sessionAverageResult: Double? = nil


    //this init is for creating a new session
    init() {
        self.testState = .dormant
        resetRandomTimeInterval()
    }

    //this init is to be used to recreate a session that had a false start
    init(results sessionResults: [TimeInterval], resultCount: Int) {
        self.testState = .dormant
        self.sessionResults = sessionResults
        self.resultCount = resultCount
        resetRandomTimeInterval()
    }


    func resetRandomTimeInterval () {
        randomTimeInterval = Double.random(in: minRandomWaitTime..<maxRandomWaitTime)
    }

    func waitRandomTime () {
        testState = .waitingRandomTime
        DispatchQueue.main.asyncAfter(deadline: .now() + randomTimeInterval) {
            if (self.testState == .waitingRandomTime) {
                print("Timer fired!")
                self.testStartTime = Date.now
                self.testState = .waitingForUser
            } else {
                print("user must have false started")
                //Option 1 -> have the loop check every half a second if there is a false start and cancel the timer
                //Option 2 -> abandon this timer and create a new one, this would be done in TestLogic
//                self.recentReaction = nil
//                self.testState = .dormant
            }
        }
        resetRandomTimeInterval()
    }

    func recordUserReaction () {
        print("recording user reaction")
        if (testState == .waitingForUser) {
            recentReaction = Date().timeIntervalSince(testStartTime)
            if let result = recentReaction {
                sessionResults += [result]
                resultCount += 1
            }
        }
        if (resultCount == maxResultCount) {
            calculateAverage()
            testState = .endOfSession
        } else {
            testState = .dormant
        }
    }

    func getRecentResult() -> TimeInterval? {
        recentReaction
    }

    func calculateAverage() {
        var totalTime: Double = 0
        for result in sessionResults {
            totalTime += result
        }
        sessionAverageResult = totalTime / Double (maxResultCount)
    }





    

}

enum timerState {
    case dormant
    case waitingForUser
    case waitingRandomTime
    case falseStart
    case endOfSession
}
