//
//  TestView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 07/07/2025.
//

import SwiftUI

struct TestView: View {

    @State var model: Controller = Controller()

    var body: some View {
        getViewFromTestState(model.testState, model)
    }
}

@ViewBuilder func getViewFromTestState(_ state: timerState, _ model: Controller) -> some View {
    switch (state) {
    case .dormant:
        DormantView(prevResult: model.recentResult)
    case .endOfSession:
        EndOfSessionView(model: model)
    case .waitingForUser:
        WaitingForUserView()
    case .waitingRandomTime:
        WaitingRandomTimeView()
    case .falseStart:
        FalseStartView()
    }
}



#Preview {
    TestView()
}

