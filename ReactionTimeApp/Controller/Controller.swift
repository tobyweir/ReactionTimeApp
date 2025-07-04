//
//  Controller.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

@Observable class Controller {
    var testModel: TestLogic = TestLogic()
    var resultStore: ResultStore = ResultStore()

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

    func storeSessionResult () {
        if let average = testModel.recentSessionResult {
            var result = Result(average: average)
            resultStore.add(result)
        }
    }

}
