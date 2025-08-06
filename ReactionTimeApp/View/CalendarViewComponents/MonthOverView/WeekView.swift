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
    @State var dayViews: [DayView] = []
    var monthDigits: String

    init(start: Date, model: Controller, monthDigits: String) {
        self.startDate = start
        self.model = model
        self.monthDigits = monthDigits
//        self.dayViews = createDayViews(date: start)

    }

    func populateDayViews () {
        dayViews = createDayViews(date: startDate)
    }
    func createDayViews (date: Date) -> [DayView] {
        var currDate = date
        var views: [DayView] = []
        for index in 0..<7 {
            let result = createDayView(for: Day.getWeekday(from: index), against: currDate)
            views.append(result.0)
            if (result.1 == true) {
                currDate = currDate.getNextDay()
            }
        }
        return views
    }
    func createDayView (for day: Day , against date: Date) -> (DayView , Bool) {
        let dayToCompare = date.formatted(Date.FormatStyle().weekday(.abbreviated))
        let monthToCompare = date.formatted(Date.FormatStyle().month(.twoDigits))
        if (day.rawValue == dayToCompare && monthToCompare == monthDigits) {
            let dayView = DayView(date: date, dayType: .weekday, model: model)
            return (dayView , true)
        } else {
            return (DayView(date: nil, dayType: .invalid, model: Controller()) , false)
        }
    }
    var body: some View {
        HStack (spacing: 0){
            ForEach(dayViews, id: \.id) { view in
                view
            }
        }
        .onAppear(perform: populateDayViews)
    }
}

#Preview {
    let startDate = Date.now.addingTimeInterval(-UsefulTimeIntervals.day.rawValue * 5)
    WeekView(start: startDate , model: Controller(), monthDigits: startDate.formatted(Date.FormatStyle().month(.twoDigits)))
}

