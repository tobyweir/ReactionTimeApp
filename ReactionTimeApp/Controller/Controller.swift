//
//  Controller.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

@Observable class Controller {
    var testModel: TestLogic = TestLogic()

    var testState: timerState {
        testModel.testState
    }

    var recentResult: TimeInterval? {
        testModel.recentResult
    }

    var resultCount: Int {
        testModel.resultCount
    }

    var recentSessionResult: Double? {
        testModel.recentSessionResult
    }

    func pressTimerButton () {
        testModel.pressTimerButton()
    }

    func saveSessionResult () {
        if let _ = testModel.recentSessionResult {
            //store.saveResult(result)
        }
    }

}
