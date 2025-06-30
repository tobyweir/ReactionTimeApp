//
//  Timer.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

class TestTimer {
    @Published var testState: TestState = .dormant
    var randomTimeInterval: Double = 0
    var testStartTime = 0
    var testEndTime = 0
    var recentReaction = 0

    init() {
        self.testState = .dormant
    }


    func resetRandomTimeInterval () {
        randomTimeInterval = Double.random(in: 0.3..<7)
    }

    func waitRandomTime () {
        testState = .waitingRandomTime
        DispatchQueue.main.asyncAfter(deadline: .now() + randomTimeInterval) {
            if (self.testState == .waitingRandomTime) {
                print("Timer fired!")
                self.testStartTime = 1
                self.testState = .waitingForUser
            } else {
                print("user must have false started")
                self.testState = .dormant
            }
        }
        resetRandomTimeInterval()
    }

    func recordUserReaction () {
        print("recording user reaction")
        if (testState == .waitingForUser) {
            testEndTime = 1
            recentReaction = testEndTime - testStartTime
        }
        testState = .dormant
    }





    

}

enum TestState {
    case dormant
    case waitingForUser
    case waitingRandomTime
    case falseStart
}
