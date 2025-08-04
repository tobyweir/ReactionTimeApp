//
//  MonthView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 31/07/2025.
//

import SwiftUI

struct MonthView: View {
    let start: Date
    let model: Controller

    var body: some View {
        Text("temp")
    }

    func createWeekViews() -> [WeekView] {
        var weekViews: [WeekView] = []
        for index in 0..<6 {

        }
    }

    func createWeekView (against start: Date) -> WeekView {
        WeekView(start: start, model: model)
    }
}

#Preview {
    //MonthView()
}
