//
//  WaitingForUserView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct WaitingForUserView: View {
    @Namespace private var animation
    var model: Controller
    var body: some View {
        Button {
                model.pressTimerButton()
        } label: {
            Text("Go!")
                .foregroundStyle(.white)
                .padding([.top , .bottom] , 50)
                .padding([.horizontal] , 125)
                .background(RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(.green))
        }
    }
}

#Preview {
    WaitingForUserView(model: Controller())
}
