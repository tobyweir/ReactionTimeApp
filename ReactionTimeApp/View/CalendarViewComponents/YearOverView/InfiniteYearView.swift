//
//  InfiniteYearView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//

import SwiftUI

struct InfiniteYearView: View {
    @State var years: [Int]
    @State var currYear: Int

    init(currYear: Int) {
        self.years = [currYear]
        self.currYear = currYear
    }

    var body: some View {
        Text("stop")
    }
}

#Preview {
    InfiniteYearView(currYear: 2025)
}
