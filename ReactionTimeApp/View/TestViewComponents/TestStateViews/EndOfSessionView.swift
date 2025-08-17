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

    var upperContent: some View {
        VStack {
            Text("You averaged a reaction time of")
            if let result = model.recentSessionResult {
                Text("\(Int (result * 1000))ms")
            } else {
                Text("")
            }
        }
    }

    var lowerContent: some View {
        HStack {
            saveButton
            //shareButton
        } .padding(15)
    }
    var buttonContent: some View {
            Text("New Session")
                .foregroundStyle(.white)
                .padding(50)
    }

    var saveButton: some View {
        Button {
            model.storeSessionResults() } label: { model.haveSaved ? Text("Saved") : Text("Save") }.disabled(model.haveSaved)
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
