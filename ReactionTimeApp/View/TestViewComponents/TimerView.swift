//
//  TimerView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 30/06/2025.
//

import SwiftUI

struct TimerView: View {
    let timer = TestTimer()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text("state -> \(timer.testState)")
        timerButton
    }

    var timerButton: some View {
        Button {
            if (timer.testState == .dormant) {
                timer.waitRandomTime()
            }
            else if (timer.testState == .waitingForUser) {
                timer.recordUserReaction()
            }
            else if (timer.testState == .waitingRandomTime) {
                timer.testState = .falseStart
            }

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
