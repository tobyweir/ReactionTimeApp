//
//  FalseStartView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct FalseStartView: View {
    @State var HapticTrigger = false
    var model: Controller
    var body: some View {
//        VStack(spacing: 30 ) {
//            VStack(spacing: 10) {
//                Text("You pressed too early")
//                Text("Wait for the button to turn green")
//            }
        buttonContent
//        }
    }

    var buttonContent: some View {
            Text("Try Again")
                .foregroundStyle(.black)
                .padding(35)
                .sensoryFeedback(.error, trigger: HapticTrigger)
                .onAppear {
                    HapticTrigger = true
                }
    }

}

    #Preview {
    FalseStartView(model: Controller())
}
