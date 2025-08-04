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

    init(start: Date, model: Controller) {
        self.start = start
        self.model = model
    }

    var body: some View {
        let weekViews: [WeekView] = createWeekViews(start: start, model: model)
        VStack {
            Text("\(start.formatted(Date.FormatStyle().month(.abbreviated)))")
                .font(.system(size: 30, weight: .heavy, design: .monospaced))
            ForEach(weekViews) { view in
                view
            }
        }
    }

    func createWeekViews(start: Date , model: Controller) -> [WeekView] {
            let monthDigits = start.formatted(Date.FormatStyle().month(.defaultDigits))
            var result: [WeekView] = [WeekView(start: start, model: model, monthDigits: monthDigits)]
            let currentWeekday = start.formatted(Date.FormatStyle().weekday(.oneDigit))
            let dayDifference: Int = 8 - Int(currentWeekday)!
            let secondWeek = start.addingTimeInterval(UsefulTimeIntervals.day.rawValue * Double (dayDifference) )
            var currDate: Date = secondWeek
            for _ in 0..<5 {
                result.append(WeekView(start: currDate, model: model, monthDigits: monthDigits))
                currDate = currDate.addingTimeInterval(UsefulTimeIntervals.day.rawValue * 7)
            }
            return result
        }

}

#Preview {
    let startDate = Date.now.addingTimeInterval(-UsefulTimeIntervals.day.rawValue * 3)
    MonthView(start: startDate, model: Controller())
}
