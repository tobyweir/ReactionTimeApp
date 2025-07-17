//
//  Controller.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

@MainActor
@Observable class Controller {
    var testModel: TestLogic = TestLogic()
    var resultStore: ResultStore = ResultStore()
    var testState: timerState = .loading
    var recentResult: TimeInterval? = nil
    var recentSessionResult: Double? = nil
    var haveSaved: Bool = true

    func loadModel () {
        
    }
    func getTestState () async -> timerState {
        await testModel.getTestState()
    }

    func getRecentResult () async -> TimeInterval? {
        await testModel.getRecentResult()
    }


    func getRecentSessionResult () async -> Double? {
        await testModel.getRecentSessionResult()
    }

    func pressTimerButton () {
        Task {
            await testModel.pressTimerButton()
        }
    }

    func storeSessionResult () {
        Task {
            if let sessionResult = await testModel.getRecentSessionResult() {
                if (await testModel.getHaveSaved() == false) {
                    resultStore.add(Result(average: sessionResult))
                    await testModel.toggleHaveSaved()
                }
            }
        }
    }

}
