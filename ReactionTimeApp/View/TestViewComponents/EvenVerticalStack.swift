//
//  EvenVerticalStack.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 23/07/2025.
//

import SwiftUI

struct EvenVerticalStack: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var subViewCount = subviews.count


        let heightDifference = bounds.size.height / CGFloat (subViewCount)
        let width = bounds.size.width
        let midWidth = width / CGFloat (2)
        var lowerHeight: CGFloat = 0
        for(index, subview) in subviews.enumerated() {
            let upperHeight = heightDifference + lowerHeight
            let midHeight = (upperHeight + lowerHeight) / CGFloat (2)
            let point = CGPoint (x: midWidth , y: midHeight)
            subview.place(at: point, anchor: .center, proposal: .unspecified)
            lowerHeight = upperHeight //set the lowerheight for next run of the loop

        }
    }
    

}
