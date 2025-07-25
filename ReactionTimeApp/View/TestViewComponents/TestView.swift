//
//  TestView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 07/07/2025.
//

import SwiftUI

struct TestView: View {

    @State var model: Controller = Controller()
    @Environment(\.colorScheme) var colorScheme
    var buttonBackground: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(width: width, height: height)
            .foregroundStyle(color)
    }

    var body: some View {
        VStack {
            Spacer()
                getUpperContent(state: model.testState, model: model)
            Spacer()
            testButton
            Spacer()
            getLowerContent(state: model.testState,model: model)
            Spacer()

        }
    }

    var testButton: some View {
        Button {
            withAnimation(.spring) {
                model.pressTimerButton()
            }
        } label: {
            ZStack {
                buttonBackground
                getTestButtonContentView(model.testState, model)

            }
        }
    }

    var cornerRadius: Double {
        switch (model.testState) {
        case .dormant:
            100
        case .waitingForUser:
            15
        case .waitingRandomTime:
            15
        case .endOfSession:
            100
        case .loading:
            10
        case .falseStart:
            100
        }
    }

    var width: Double {
        switch (model.testState) {
        case .dormant:
            100
        case .waitingForUser:
            300
        case .waitingRandomTime:
            300
        case .endOfSession:
            125
        case .loading:
            10
        case .falseStart:
            100
        }
    }

    var height: Double {
        switch (model.testState) {
        case .dormant:
            100
        case .waitingForUser:
            200
        case .waitingRandomTime:
            200
        case .endOfSession:
            125
        case .loading:
            10
        case .falseStart:
            100
        }
    }

    var color: Color {
        switch (model.testState) {
        case .dormant:
                .blue
        case .waitingForUser:
                .green
        case .waitingRandomTime:
                .red
        case .endOfSession:
                .blue
        case .loading:
                .yellow
        case .falseStart:
                .yellow
        }
    }

}

//function to get content displayed inside of the button dependant on the state of the test
@MainActor @ViewBuilder func getTestButtonContentView(_ state: timerState, _ model: Controller) -> some View {
    switch (state) {
    case .dormant:
        DormantView(model: model).buttonContent
    case .endOfSession:
        EndOfSessionView(model: model).buttonContent
    case .waitingForUser:
        WaitingForUserView(model: model).buttonContent
    case .waitingRandomTime:
        WaitingRandomTimeView(model: model).buttonContent
    case .falseStart:
        FalseStartView(model: model).buttonContent
    case .loading:
        LoadingView()
    }
}

@MainActor @ViewBuilder func getUpperContent (state: timerState, model: Controller) -> some View {
    switch (state) {
    case .dormant:
        DormantView(model: model).upperContent
    case .endOfSession:
        EndOfSessionView(model: model).upperContent
    case .falseStart:
        FalseStartView(model: model).upperContent
    default:
        EmptyView()
    }
}

@MainActor @ViewBuilder func getLowerContent (state: timerState, model: Controller) -> some View {
    switch (state) {
    case .endOfSession:
        EndOfSessionView(model: model).lowerContent
    default:
        EmptyView()
    }
}


#Preview {
    TestView()
}

