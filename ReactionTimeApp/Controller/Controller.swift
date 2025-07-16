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

    var recentSessionResult: Double? {
        testModel.recentSessionResult
    }

    func pressTimerButton () {
        testModel.pressTimerButton()
    }

    func storeSessionResult () {
        if  testModel.recentSessionResult != nil && testModel.savedResult == false {
            let result = Result(average: testModel.recentSessionResult!)
            resultStore.add(result)
            testModel.savedResult = true
        }
    }

}
