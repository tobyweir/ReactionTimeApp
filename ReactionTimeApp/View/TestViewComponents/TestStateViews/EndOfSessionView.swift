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

       buttonContent

    }
    var buttonContent: some View {
            Text("New Session")
                .foregroundStyle(.white)
                .padding(50)
    }

    var saveButton: some View {
        Button {
            model.storeSessionResult() } label: { model.haveSaved ? Text("Saved") : Text("Save") }.disabled(model.haveSaved)
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
