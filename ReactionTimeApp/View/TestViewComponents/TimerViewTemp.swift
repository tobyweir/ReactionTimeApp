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

#Preview {
  TimerViewTemp()
}
