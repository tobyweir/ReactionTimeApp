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
    }

    //this init is to be used to recreate a session that had a false start
    init(results sessionResults: [TimeInterval], resultCount: Int) {
        self.testState = .dormant
        self.sessionResults = sessionResults
        self.resultCount = resultCount
    }


    func resetRandomTimeInterval () {
        randomTimeInterval = Double.random(in: minRandomWaitTime..<maxRandomWaitTime)
    }

    func getRandomTimeInterval () -> TimeInterval {
        TimeInterval(Double.random(in: minRandomWaitTime..<maxRandomWaitTime))
    }

    func waitRandomTime ()  {
        testState = .waitingRandomTime
         updateStateAfterTimer()
    }

    func updateStateAfterTimer ()  {
        let timeToWait = getRandomTimeInterval()
        let timer = Timer.scheduledTimer(withTimeInterval: timeToWait, repeats: false) { timer in
            self.testState = .waitingForUser
            self.testStartTime = Date.now
        }
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
    case loading
    case dormant
    case waitingForUser
    case waitingRandomTime
    case falseStart
    case endOfSession
}
