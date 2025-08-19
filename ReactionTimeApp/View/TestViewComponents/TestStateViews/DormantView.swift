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
    var upperContent: some View {
        if let result = model.recentResult {  
                Text("\(Int (result * 1000))ms")
                .font(.system(size: 30))

        } else {
            Text("")
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
                .font(.system(size: 15))
                .padding(35)
                .foregroundStyle(.white)
            //                .background(buttonBackground)


    }
}

//#Preview {
//    DormantView(model: Controller()).continueTestView
//    DormantView(model: Controller()).startTestView
//}
