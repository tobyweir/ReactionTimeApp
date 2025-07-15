//
//  DormantView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct DormantView: View {
    var model: Controller
    @Namespace private var animation
    var body: some View {
        if let result = model.recentResult {
            Text("\(result)").bold()
            continueTestView
                .matchedGeometryEffect(id: "TestButton", in: animation)
        } else {
            startTestView
                .matchedGeometryEffect(id: "TestButton", in: animation)
        }
    }


    @ViewBuilder
    var continueTestView: some View {
        Button {
            withAnimation(.spring()){
                model.pressTimerButton()
            }
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
            withAnimation(.spring()) {
                model.pressTimerButton()
            }
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
