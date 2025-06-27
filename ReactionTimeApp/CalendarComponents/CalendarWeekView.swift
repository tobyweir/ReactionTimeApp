//
//  CalendarWeekView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 26/06/2025.
//

import SwiftUI
let dayCount: Int = 7
struct CalendarWeekView: View {
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<dayCount, id: \.self) { index in
                CalendarDayView(dayType: .weekday)
            }
        }
    }
}

#Preview {
    CalendarWeekView()
}
