//
//  Timer.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

@Observable class TestTimer {
    var testState: timerState = .dormant
    var randomTimeInterval: Double = 0
    var testStartTime: Date = Date.now
    var recentReaction: TimeInterval? = nil
    var minRandomWaitTime: Double
    var maxRandomWaitTime: Double


    
    init() {
        self.testState = .dormant
        self.minRandomWaitTime = 0.3
        self.maxRandomWaitTime = 7.0
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
        }
        testState = .dormant
    }

    func getRecentResult() -> TimeInterval? {
        recentReaction
    }





    

}

enum timerState {
    case dormant
    case waitingForUser
    case waitingRandomTime
    case falseStart
}
