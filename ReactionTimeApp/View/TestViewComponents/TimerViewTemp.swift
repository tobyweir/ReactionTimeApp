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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text("Result Count: \(model.resultCount)")
        Text("Recent Reaction: \(String(describing: model.recentResult))")
        Text("Recent Average: \(String(describing: model.recentSessionResult))")
        Text("Test State -> \(model.testState)")
        testButton
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
