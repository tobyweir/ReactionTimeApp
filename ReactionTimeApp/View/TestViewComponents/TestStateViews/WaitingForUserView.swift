//
//  WaitingForUserView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct WaitingForUserView: View {
    @Namespace private var animation
    @State var Trigger = false
    var model: Controller
    var body: some View {
            Text("Go!")
                .foregroundStyle(.white)
                .padding([.top , .bottom] , 50)
                .padding([.horizontal] , 125)
    }

    var buttonContent: some View {
        Text("Go!")
            .foregroundStyle(.white)
            .padding([.top , .bottom] , 50)
            .padding([.horizontal] , 125)
            .sensoryFeedback(.start , trigger: Trigger)
            .onAppear {
                print("haptic feedback should play")
                Trigger = true
            }
    }


}

#Preview {
    WaitingForUserView(model: Controller())
}
