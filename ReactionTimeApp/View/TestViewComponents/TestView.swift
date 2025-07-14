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
        DormantView(model: model)
    case .endOfSession:
        EndOfSessionView(model: model)
    case .waitingForUser:
        WaitingForUserView(model: model)
    case .waitingRandomTime:
        WaitingRandomTimeView(model: model)
    case .falseStart:
        FalseStartView(model: model)
    }
}



#Preview {
    TestView()
}

