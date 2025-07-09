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
        Button {
            model.pressTimerButton()
        } label: {
            Rectangle()
                .frame(width: 100, height: 50)
        }

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

struct EndOfSessionView: View {
    var model: Controller
    var body: some View {
        Text("Average Result: \(model.recentSessionResult!)")
        saveButton
    }

    var saveButton: some View {
        Button {
            model.storeSessionResult()
        } label: {
            model.testModel.savedResult ? Text("Saved") : Text("Save")
        }.disabled(model.testModel.savedResult)

    }
}

struct WaitingRandomTimeView: View {
    var body: some View {
        Text("Wait")
    }
}

struct WaitingForUserView: View {
    var body: some View {
        Text("Press now!")
    }
}

struct DormantView: View {
    var prevResult: Double?
    var body: some View {
        if let _ = prevResult {
            continueTestView
        } else {
            startTestView
        }
    }
    @ViewBuilder
    var continueTestView: some View {
        Text("Result: \(prevResult!)")
        Text("continue the test")
    }
    @ViewBuilder
    var startTestView: some View {
        Text("start the test")
    }
}

struct FalseStartView: View {
    var body: some View {
        Text("you pressed too early")
    }
}

#Preview {
    TestView()
}

