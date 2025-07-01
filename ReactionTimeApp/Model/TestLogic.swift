//
//  TestLogic.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

struct TestLogic {
    var timer: TestTimer = TestTimer()

    var recentResult: TimeInterval? {
        timer.recentReaction
    }

    var testState: TestState {
        timer.testState
    }
    //will handle the logic of what state the timer is in when the user presses the button
    //and how to handle that input
    //if the test is inactive then we want to display to the user to press and start a test, and a tapGesture would start the test
    //
    //if the test is waiting then we want to display the button as red and tell the user to wait for green, pressing here will result in testState set to falseStart
    //
    //if the test is active then we want to display the button as green, pressing here will result in a successful test and testState will be set to ended and the result displayed,
    //if the test is falseStart then we want to tell the user they pressed too soon, pressing again will start a new test
    //
    //if the test is ended we want to display the result, pressing again will start a new test
    
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
