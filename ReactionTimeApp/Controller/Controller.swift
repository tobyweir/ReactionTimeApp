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

    func storeSessionResults () {
            let sessionResults = testModel.getRecentSessionResults()
                if ( testModel.haveSaved == false) {
                    for result in sessionResults {
                        resultStore.add(Result(time: result))
                    }
                     testModel.toggleHaveSaved()
                }
    }

    func getResults(between date: Date , and date2: Date) -> [Result] {
        //Not implemented
        //
        []
    }

    func getResults(on date: Date) -> [Result] {
        resultStore.getResults(on: date)
    }

    func getResultsIn(month date: Date) -> [Result] {
        resultStore.getResultsIn(month: date)
    }

}
