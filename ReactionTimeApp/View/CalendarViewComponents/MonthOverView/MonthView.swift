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
    @Binding var wasdayOverViewDisplayed: Bool

    init(start: Date, model: Controller, dayOverViewStatus: Binding<Bool>) {
        self.start = start
        self.model = model
        self.weekViews = MonthView.createWeekViews(start: start, model: model, dayOverViewStatus: dayOverViewStatus)
        self._wasdayOverViewDisplayed = dayOverViewStatus
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

    static func createWeekViews(start: Date , model: Controller, dayOverViewStatus: Binding<Bool>) -> [WeekView] {
        let monthDigits = start.formatted(Date.FormatStyle().month(.twoDigits))
        var result: [WeekView] = [WeekView(start: start, model: model, monthDigits: monthDigits, dayOverViewStatus: dayOverViewStatus)]
        let currentWeekday = start.formatted(Date.FormatStyle().weekday(.oneDigit))
        let dayDifference: Int = 8 - Int(currentWeekday)!
        let secondWeek = start.addingTimeInterval(UsefulTimeIntervals.day.rawValue * Double (dayDifference) )
        var currDate: Date = secondWeek
//        let weekNum = calculateWeekNum(for: secondWeek)
        for _ in 0..<5{
            result.append(WeekView(start: currDate, model: model, monthDigits: monthDigits, dayOverViewStatus: dayOverViewStatus))
            currDate = currDate.getNextWeek()
        }
        return result
    }

}

//#Preview {
//    @Previewable @State var focusedDate = Date.createDummyDate(day: 1, month: 2, year: 2025)
//    let startDate = Date.createDummyDate(day: 1, month: 10, year: 2025)
//
//    MonthView(start: startDate, model: Controller())
//}
