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

    var haveSaved: Bool {
        testModel.haveSaved
    }


    func pressTimerButton ()  {
             testModel.pressTimerButton()
    }

    func storeSessionResult () {
            if let sessionResult = testModel.getRecentSessionResult() {
                if ( testModel.haveSaved == false) {
                    resultStore.add(Result(average: sessionResult))
                     testModel.toggleHaveSaved()
                }
            }
    }

    func getResults(between date: Date , and date2: Date) -> [Result] {
        //Not implemented
        //
        []
    }

}
