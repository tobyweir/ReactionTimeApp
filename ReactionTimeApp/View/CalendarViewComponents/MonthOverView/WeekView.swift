//
//  WeekView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//
import SwiftUI

struct WeekView: View, Identifiable {
    let id = UUID()
    let startDate: Date
    let model: Controller
    @State var dayViews: [DayView]
    @Binding var wasdayOverViewDisplayed: Bool
    var monthDigits: String

    init(start: Date, model: Controller, monthDigits: String, dayOverViewStatus: Binding<Bool>) {
        self.startDate = start
        self.model = model
        self.monthDigits = monthDigits
        self.dayViews = WeekView.createDayViews(date: start, monthDigits: monthDigits, model: model, dayOverViewStatus: dayOverViewStatus)
        self._wasdayOverViewDisplayed = dayOverViewStatus

    }

    static func createDayViews (date: Date, monthDigits: String, model: Controller, dayOverViewStatus: Binding<Bool>) -> [DayView] {
        var currDate = date
        var views: [DayView] = []
        for index in 0..<7 {
            let result = createDayView(for: Day.getWeekday(from: index), against: currDate, monthDigits: monthDigits, model: model, dayOverViewStatus: dayOverViewStatus)
            views.append(result.0)
            if (result.1 == true) {
                currDate = currDate.getNextDay()
            }
        }
        return views
    }

    static func createDayView (for day: Day , against date: Date, monthDigits: String, model: Controller, dayOverViewStatus: Binding<Bool>) -> (DayView , Bool) {
        let dayToCompare = date.formatted(Date.FormatStyle().weekday(.abbreviated))
        let monthToCompare = date.formatted(Date.FormatStyle().month(.twoDigits))
        if (day.rawValue == dayToCompare && monthToCompare == monthDigits) {
            let dayView = DayView(date: date, dayType: .weekday, model: model, dayOverViewStatus: dayOverViewStatus)
            return (dayView , true)
        } else {
            return (DayView(date: nil, dayType: .invalid, model: model, dayOverViewStatus: dayOverViewStatus) , false)
        }
    }
    var body: some View {
        HStack (spacing: 0){
            ForEach(dayViews, id: \.id) { view in
                view
            }
        }
    }
}

//#Preview {
//    let startDate = Date.now.addingTimeInterval(-UsefulTimeIntervals.day.rawValue * 1)
//    WeekView(start: startDate , model: Controller(), monthDigits: startDate.formatted(Date.FormatStyle().month(.twoDigits)))
//}

