//
//  DormantView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 14/07/2025.
//

import SwiftUI

struct DormantView: View {
    var prevResult: Double?
    var body: some View {
        if let _ = prevResult {
            continueTestView
        } else {
            startTestView
        }
    }
    @ViewBuilder
    var continueTestView: some View {
        Text("Result: \(prevResult!)")
        Text("continue the test")
    }
    @ViewBuilder
    var startTestView: some View {
        Text("start the test")
    }
}

#Preview {
    DormantView()
}
