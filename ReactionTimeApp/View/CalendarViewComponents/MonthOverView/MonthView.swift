//
//  MonthView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 31/07/2025.
//

import SwiftUI

struct MonthView: View , Identifiable {
    let id = UUID()
    let start: Date
    let model: Controller
    @State var weekViews: [WeekView]

    init(start: Date, model: Controller) {
        self.start = start
        self.model = model
        self.weekViews = MonthView.createWeekViews(start: start, model: model)
    }

    var body: some View {
//        let weekViews: [WeekView] = createWeekViews(start: start, model: model)
        VStack {
            Text("\(start.formatted(Date.FormatStyle().month(.abbreviated)))")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
            ForEach(weekViews) { view in
                view
            }
        }
    }

    static func calculateWeekNum(for date: Date) -> Int {
        let currMonth: String = date.formatted(Date.FormatStyle().month(.twoDigits))
        var currDate  = date
        var weekNum = 0
        while (currMonth == currDate.formatted(Date.FormatStyle().month(.twoDigits))) {
            currDate = currDate.addingTimeInterval(UsefulTimeIntervals.day.rawValue * 7)
            weekNum += 1
        }
        return weekNum
    }

    static func createWeekViews(start: Date , model: Controller) -> [WeekView] {
        let monthDigits = start.formatted(Date.FormatStyle().month(.twoDigits))
        var result: [WeekView] = [WeekView(start: start, model: model, monthDigits: monthDigits)]
        let currentWeekday = start.formatted(Date.FormatStyle().weekday(.oneDigit))
        let dayDifference: Int = 8 - Int(currentWeekday)!
        let secondWeek = start.addingTimeInterval(UsefulTimeIntervals.day.rawValue * Double (dayDifference) )
        var currDate: Date = secondWeek
//        let weekNum = calculateWeekNum(for: secondWeek)
        for _ in 0..<5{
            result.append(WeekView(start: currDate, model: model, monthDigits: monthDigits))
            currDate = currDate.getNextWeek()
        }
        return result
    }

}

#Preview {
    let startDate = Date.createDummyDate(day: 1, month: 10, year: 2025)
    MonthView(start: startDate, model: Controller())
}
