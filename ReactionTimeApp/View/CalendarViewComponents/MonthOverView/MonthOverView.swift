//
//  MonthOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

import SwiftUI

struct MonthOverView: View {
    var currMonth: Month = .January
    var currYear: Int = 2000
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text("\(Month.getCenturyCode(for: -800) ?? -1 )")
    }
}

#Preview {
    MonthOverView()
}
