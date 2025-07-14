//
//  EndOfSessionView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct EndOfSessionView: View {
    var model: Controller

    var body: some View {
        Text("Average Result: \(model.recentSessionResult)")
        Text("Press to start a new test")
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

#Preview {
    EndOfSessionView(model: Controller())
}
