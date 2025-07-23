//
//  WaitingRandomTimeView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct WaitingRandomTimeView: View {
    @Namespace private var animation
    var model: Controller
    var body: some View {
            Text("Wait")
                .foregroundStyle(.white)
                .padding([.top , .bottom] , 50)
                .padding([.horizontal] , 125)
    }

    var buttonContent: some View {
        Text("Wait")
            .foregroundStyle(.white)
            .padding([.top , .bottom] , 50)
            .padding([.horizontal] , 125)
    }

}

#Preview {
    WaitingRandomTimeView(model: Controller())
}
