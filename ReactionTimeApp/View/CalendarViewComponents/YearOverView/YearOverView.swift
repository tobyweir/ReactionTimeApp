//
//  YearOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//

import SwiftUI

struct YearOverView: View {
    @State var date: Date
    let model: Controller
    var body: some View {
        NavigationStack {
            MonthOverView(currMonth: $date, model: model)
        }
    }
}

#Preview {
    YearOverView(date: Date.createDummyDate(day: 1, month: 8, year: 2025), model: Controller())
}
