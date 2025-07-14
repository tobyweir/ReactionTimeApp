//
//  DormantView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct DormantView: View {
    var model: Controller
    var body: some View {
        if let result = model.recentResult {
            Text("\(result)").bold()
            continueTestView
        } else {
            startTestView
        }
    }


    @ViewBuilder
    var continueTestView: some View {
        Button {
            model.pressTimerButton()
        } label: {
            Text("Continue")
                .padding(35)
                .foregroundStyle(.white)
                .background(Circle().tint(.blue))
        }
    }

    @ViewBuilder
    var startTestView: some View {
        Button {
            model.pressTimerButton()
        } label: {
            Text("Start")
                .padding(35)
                .foregroundStyle(.white)
                .background(Circle().tint(.blue))
        }

    }
}

#Preview {
    DormantView(model: Controller()).continueTestView
    DormantView(model: Controller()).startTestView
}
