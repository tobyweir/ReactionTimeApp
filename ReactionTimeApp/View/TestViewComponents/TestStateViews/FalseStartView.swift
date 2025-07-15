//
//  FalseStartView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct FalseStartView: View {
    @Namespace private var animation
    var model: Controller
    var body: some View {
        VStack(spacing: 30 ) {
            VStack(spacing: 10) {
                Text("You pressed too early")
                Text("Wait for the button to turn green")
            }

            tryAgainButton
                .matchedGeometryEffect(id: "TestButton", in: animation)
        }
    }

    var tryAgainButton: some View {
        Button {
            withAnimation(.spring()) {
                model.pressTimerButton()
            }
        } label: {
            Text("Try Again")
            .foregroundStyle(.black)
            .padding(35)
            .background(Circle()
                .foregroundStyle(.yellow))
        }
    }


}

#Preview {
    FalseStartView(model: Controller())
}
