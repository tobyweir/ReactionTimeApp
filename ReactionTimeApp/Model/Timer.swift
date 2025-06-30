//
//  Timer.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import Foundation

class Timer {
    @Published var testState: TestState = .inactive
    var endTime = 0
    let testStartTime = 0
    var currentTime = 0

    init() {
        self.testState = .inactive
    }

    

}

enum TestState {
    case inactive
    case active
    case waiting
    case falseStart
    case ended
}
