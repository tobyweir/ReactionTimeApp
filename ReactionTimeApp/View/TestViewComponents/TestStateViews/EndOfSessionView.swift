//
//  EndOfSessionView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct EndOfSessionView: View {
    var model: Controller
    @Namespace private var animation
    var body: some View {
        if let sessionResult = model.recentSessionResult {
            Text("Average Result: \(sessionResult)")
        }
        startAgainButton
        HStack(spacing: 20) {
            saveButton
            shareButton
        }
    }
    var startAgainButton: some View {
        Button {
                model.pressTimerButton()
        } label: {
            Text("New Session")
                .foregroundStyle(.white)
                .padding(50)
                .background(Circle()
                    .foregroundStyle(.blue))
        }

    }
    var saveButton: some View {
        Button {
            model.storeSessionResult() } label: { model.testModel.savedResult ? Text("Saved") : Text("Save") }.disabled(model.testModel.savedResult)
    }

    var shareButton: some View {
        Button {

        } label: {
            Text("Share")
        }

    }
}

#Preview {
    EndOfSessionView(model: Controller())
}
