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
    } //We will use a didSet here to send new results to the ResultStore, if the result is nil we will not send it



    func pressTimerButton () {
        testModel.pressTimerButton()
    }

}
