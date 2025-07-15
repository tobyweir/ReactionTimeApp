//
//  TimerViewTemp.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 02/07/2025.
//

import SwiftUI

struct TimerViewTemp: View {
    @State var model: Controller = Controller()
    var body: some View {
        Text("Stored Results: \(model.resultStore.resultCount)")
        Text("Result Count: \(model.resultCount)")
        Text("Recent Reaction: \(String(describing: model.recentResult))")
        Text("Recent Average: \(String(describing: model.recentSessionResult))")
        Text("Test State -> \(model.testState)")
        testButton
        saveButton
    }

    var saveButton: some View {
        Button {
            model.storeSessionResult()
        } label: {
            Text("Save")
        }.disabled(model.testState != .endOfSession)

    }
    var testButton: some View {
        Button {
            model.pressTimerButton()
        } label: {
            Text("Press here for timer")
        }

    }
}

struct TESTER: View {
    @Namespace var namespace

    @State private var isFullScreen = false
    @State private var stateNum = 0


    var body: some View {
        originalExample
    }

    var originalExample: some View {
        VStack {
            if !isFullScreen {
                ZStack {
                    AnimatableRoundedRectangle()
                        .foregroundColor(.orange)
                        .matchedGeometryEffect(id: "card", in: namespace)
                        .frame(width: 100, height: 100)
                }
                .transition(.cornerRadius(identity: 60.0, active: 60.0))
            } else {
                ZStack {
                    AnimatableRoundedRectangle()
                        .foregroundColor(.orange)
                        .matchedGeometryEffect(id: "card", in: namespace)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                .transition(.cornerRadius(identity: 60.0, active: 60.0))
            }
        }
        .animation(.linear, value: isFullScreen)
        .onTapGesture { isFullScreen.toggle() }
        .preferredColorScheme(.dark)
    }
}

#Preview {
   TESTER()
}
