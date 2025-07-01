//
//  TimerView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import SwiftUI

struct TimerView: View {
    @State var model: Controller = Controller()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text("\(String(describing: model.recentResult))")
        Text("state -> \(model.testState)")
        timerButton
    }


    var timerButton: some View {
        Button {
            model.pressTimerButton()
        } label: {
            Text("Press here to wait random time")
        }
    }

    var reactionButton: some View {
        Button {
            print("reaction")
        } label: {
            RoundedRectangle(cornerRadius: 12)
        }

    }
}

#Preview {
    TimerView()
}
