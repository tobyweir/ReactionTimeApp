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
        getTestButtonContentView(model.testState, model)

    }
}
//function to get extra information about the test based on the test state. e.g The previous result of the test, to be displayed above the button
func getTestInfoView () {

}

//function to get content displayed inside of the button dependant on the state of the test
@ViewBuilder func getTestButtonContentView(_ state: timerState, _ model: Controller) -> some View {
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

