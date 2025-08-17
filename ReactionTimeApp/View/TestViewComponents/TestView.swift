//
//  TestView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 07/07/2025.
//

import SwiftUI

struct TestView: View {

    @State var model: Controller
    @Environment(\.colorScheme) var colorScheme
    var buttonBackground: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(minWidth: 100 , minHeight: 100)
            .scaleEffect(x: scaleFactorX, y: scaleFactorY, anchor: .center)
            .aspectRatio(1, contentMode: .fit)
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
            200
        case .waitingForUser:
            30
        case .waitingRandomTime:
            30
        case .endOfSession:
            200
        case .loading:
            100
        case .falseStart:
            200
        }
    }

    var scaleFactorX: Double {
        switch (model.testState) {
        case .dormant:
            0.33
        case .waitingForUser:
            0.8
        case .waitingRandomTime:
            0.8
        case .endOfSession:
            0.33
        case .falseStart:
            0.33
        default:
            0.5
        }
    }

    var scaleFactorY: Double {
        switch(model.testState) {
        case .dormant:
            0.33
        case .waitingForUser:
            0.50
        case .waitingRandomTime:
            0.50
        case .endOfSession:
            0.33
        case .falseStart:
            0.33
        default:
            0.10
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
    TestView(model: Controller())
}

