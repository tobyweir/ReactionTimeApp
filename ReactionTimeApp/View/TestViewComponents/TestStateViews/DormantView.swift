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
        if let _ = model.recentResult {
            continueTestView
        } else {
            startTestView
        }
    }

    @ViewBuilder
    var buttonContent: some View {
        if let _ = model.recentResult {
            continueTestView
        } else {
            startTestView
        }
    }
    
    @ViewBuilder
    var continueTestView: some View {
            Text("Continue")
                .padding(35)
                .foregroundStyle(.white)
//                .background(buttonBackground)
    }



    @ViewBuilder
    var startTestView: some View {
            Text("Start")
                .padding(35)
                .foregroundStyle(.white)
            //                .background(buttonBackground)


    }
}

#Preview {
    DormantView(model: Controller()).continueTestView
    DormantView(model: Controller()).startTestView
}
